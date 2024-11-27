module Features
  module ForecastHelper
    def stub_cerc_api_with(forecasts)
      forecast_response = Fixtures::API.all_forecasts(forecasts)
      HttpStubs.stub_forecasts_with(forecast_response)
    end

    def switch_to_tab_for(day)
      case day
      when :tomorrow
        find(".tab.tomorrow").trigger("click")
      when :day_after_tomorrow
        find(".tab.day_after_tomorrow").trigger("click")
      else
        raise "day: #{day} not expected"
      end
    end

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

    def expect_to_see_alert_level(level)
      label = case level
      when :moderate
        "Moderate"
      when :high
        "High"
      when :very_high
        "Very high"
      end

      expect(page).to have_css(".daqi-label", text: label)
    end

    def expect_to_see_guidance_for(level)
      expect(page).to have_content(I18n.t("air_quality_alert.#{level}.guidance.title"))
      expect(page).to have_content(
        I18n.t("air_quality_alert.#{level}.guidance.detail_html").truncate(20, omission: "")
      )
    end

    def expect_prediction(category:, level:)
      within(".#{category}") do
        expect_content_for(category:, level:)
      end
    end

    def expect_content_for(category:, level:)
      case category
      when :"ultraviolet-rays-uv"
        expect_uv_content_for_level(level)
      when :pollen
        expect_pollen_content_for_level(level)
      when :temperature
        expect_temperature_content_for_level(level)
      else
        raise "category #{category} not implemented"
      end
    end

    def expect_uv_content_for_level(level)
      case level
      when :low
        expect(page).to have_content("Low")
        expect(page).to have_content(I18n.t("prediction.guidance.ultraviolet_rays_uv.#{level}"))
      when :moderate
        expect(page).to have_content("Moderate")
        expect(page).to have_content(I18n.t("prediction.guidance.ultraviolet_rays_uv.#{level}"))
      when :high
        expect(page).to have_content("High")
        expect(page).to have_content(I18n.t("prediction.guidance.ultraviolet_rays_uv.#{level}"))
      else
        raise "unexpected level #{level}"
      end
    end

    def expect_pollen_content_for_level(level)
      case level
      when :low
        expect(page).to have_content("Low")
        expect(page).to have_content(I18n.t("prediction.guidance.pollen.#{level}"))
      when :moderate
        expect(page).to have_content("Moderate")
        expect(page).to have_content(I18n.t("prediction.guidance.pollen.#{level}"))
      when :high
        expect(page).to have_content("High")
        expect(page).to have_content(I18n.t("prediction.guidance.pollen.#{level}"))
      else
        raise "unexpected level #{level}"
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
      else
        raise "unexpected level #{level}"
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
      else
        raise "unexpected value #{value}"
      end
    end

    def content_for_uv(value)
      case value
      when :low
        "Low - #{I18n.t("prediction.guidance.ultraviolet_rays_uv.#{value}")}"
      when :moderate
        "Moderate - #{I18n.t("prediction.guidance.ultraviolet_rays_uv.#{value}")}"
      when :high
        "High - #{I18n.t("prediction.guidance.ultraviolet_rays_uv.#{value}")}"
      when :very_high
        "Very high - #{I18n.t("prediction.guidance.ultraviolet_rays_uv.#{value}")}"
      else
        raise "Unexpected UV value #{value}"
      end
    end

    def content_for_pollen(value)
      case value
      when :low
        "Low - #{I18n.t("prediction.guidance.pollen.#{value}")}"
      when :moderate
        "Moderate - #{I18n.t("prediction.guidance.pollen.#{value}")}"
      when :high
        "High - #{I18n.t("prediction.guidance.pollen.#{value}")}"
      when :very_high
        "Very high - #{I18n.t("prediction.guidance.pollen.#{value}")}"
      else
        raise "Unexpected Pollen value #{value}"
      end
    end
  end
end
