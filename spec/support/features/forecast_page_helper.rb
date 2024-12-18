module Features
  module ForecastPageHelper
    def expect_to_see_alert_date_for(day)
      date = case day
      when :today
        Date.today.strftime("%d %b %Y")
      when :tomorrow
        Date.tomorrow.strftime("%d %b %Y")
      when :day_after_tomorrow
        (Date.tomorrow + 1.day).strftime("%d %b %Y")
      end

      expect(page).to have_content("air quality alert for #{date}")
    end

    def expect_to_see_alert_level(label)
      expect(page).to have_css(".daqi-label", text: label)
    end

    def expect_to_see_guidance_for(level)
      expect(page).to have_content(I18n.t("air_quality_alert.#{level}.guidance.title"))
      expect(page).to have_content(
        ActionView::Base.full_sanitizer.sanitize(I18n.t("air_quality_alert.#{level}.guidance.detail_html").truncate(20, omission: ""))
      )
    end

    def expect_prediction(category:, level:)
      within(".#{category}") do
        case category
        when :uv
          expect_uv_content_for_level(level)
        when :pollen
          expect_pollen_content_for_level(level)
        when :temperature
          expect_temperature_content_for_level(level)
        end
      end
    end

    def expect_uv_content_for_level(level)
      case level
      when :low
        expect(page).to have_content("Low")
      when :moderate
        expect(page).to have_content("Moderate")
      when :high
        expect(page).to have_content("High")
      end
    end

    def expect_pollen_content_for_level(level)
      case level
      when :low
        expect(page).to have_content("Low")
      when :moderate
        expect(page).to have_content("Moderate")
      when :high
        expect(page).to have_content("High")
      end
    end

    def expect_temperature_content_for_level(level)
      case level
      when :low
        expect(page).to have_content("-5 to 4°C")
        expect(page).to have_content("23 to 38°F")
      when :moderate
        expect(page).to have_content("9 to 16°C")
        expect(page).to have_content("48 to 62°F")
      when :high
        expect(page).to have_content("27 to 31°C")
        expect(page).to have_content("80 to 88°F")
      end
    end

    def expect_air_pollution_prediction(day:, value:)
      within("div[data-date='#{date(day)}']") do
        expect(page).to have_content(content_for_air_pollution(value))
      end
    end

    def prediction_category(category)
      if category == :air_pollution
        ".air-pollution"
      else
        ".#{category}"
      end
    end

    def date(day)
      case day
      when :today
        Date.today.to_s
      when :tomorrow
        Date.tomorrow.to_s
      when :day_after_tomorrow
        (Date.today + 2.days).to_s
      end
    end

    def content_for(category:, value:)
      if category == :air_pollution
        content_for_air_pollution(value)
      else
        value
      end
    end

    def content_for_air_pollution(value)
      case value
      when :low
        "Low"
      when :moderate
        "Moderate"
      when :high
        "High"
      when :very_high
        "Very high"
      end
    end
  end
end
