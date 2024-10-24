module ForecastSteps
  def given_a_forecast_for_today
    forecasts << Fixtures::API.build_forecast(
      day: :today,
      air_pollution_status: :high,
      pollen: :low,
      temperature: :cold,
      uv: :low
    )
  end

  def and_a_forecast_for_tomorrow
    forecasts << Fixtures::API.build_forecast(
      day: :tomorrow,
      air_pollution_status: :moderate,
      pollen: :moderate,
      temperature: :normal,
      uv: :moderate
    )
  end

  def and_a_forecast_for_the_day_after_tomorrow
    forecasts << Fixtures::API.build_forecast(
      day: :day_after_tomorrow,
      air_pollution_status: :very_high,
      pollen: :high,
      temperature: :hot,
      uv: :high
    )
  end

  def forecasts
    @forecasts ||= []
  end

  def and_the_response_from_cercs_api_is_stubbed_accordingly
    forecast_response = Fixtures::API.forecast_wrapper_around(@forecasts)
    HttpStubs.stub_forecasts_with(forecast_response)
  end

  def when_i_select_view_forecasts
    click_link("View forecasts")
  end

  def when_i_select_view_forecasts_v2
    click_link("View new style forecasts")
  end

  def and_i_switch_to_the_tab_for_tomorrow
    switch_to_tab_for(:tomorrow)
  end

  def and_i_switch_to_the_tab_for_day_after_tomorrow
    switch_to_tab_for(:day_after_tomorrow)
  end

  def switch_to_tab_for(day)
    case day
    when :tomorrow
      find(".tab.tomorrow a").click
    when :day_after_tomorrow
      find(".tab.day_after_tomorrow a").click
    else
      raise "day: #{day} not expected"
    end
  end

  def then_i_see_the_forecasts_page
    expect(page).to have_content("Forecasts")
  end

  def then_i_see_the_forecasts_page_v2
    expect(page).to have_content("Air quality forecast")
  end

  def and_i_see_local_air_quality_information
    expect(page).to have_content("Three day forecast for Haringey")
  end

  def and_i_see_predicted_air_pollution_status_for_each_day
    expect_prediction(day: :today, category: :air_pollution, value: :high)
    expect_prediction(day: :tomorrow, category: :air_pollution, value: :moderate)
    expect_prediction(day: :day_after_tomorrow, category: :air_pollution, value: :very_high)
  end

  def and_i_see_predicted_air_pollution_status_for_each_day_v2
    expect_air_pollution_prediction(day: :today, value: :high)
    expect_air_pollution_prediction(day: :tomorrow, value: :moderate)
    expect_air_pollution_prediction(day: :day_after_tomorrow, value: :very_high)
  end

  def and_i_see_predicted_uv_level_for_each_day
    expect_prediction(day: :today, category: :uv, value: content_for_uv(:low))
    expect_prediction(day: :tomorrow, category: :uv, value: content_for_uv(:moderate))
    expect_prediction(day: :day_after_tomorrow, category: :uv, value: content_for_uv(:high))
  end

  def and_i_see_predicted_pollen_level_for_each_day
    expect_prediction(day: :today, category: :pollen, value: content_for_pollen(:low))
    expect_prediction(day: :tomorrow, category: :pollen, value: content_for_pollen(:moderate))
    expect_prediction(day: :day_after_tomorrow, category: :pollen, value: content_for_pollen(:high))
  end

  def and_i_see_predicted_temperature_for_each_day
    expect_prediction(day: :today, category: :temperature, value: "-5-4°C")
    expect_prediction(day: :tomorrow, category: :temperature, value: "9-16°C")
    expect_prediction(day: :day_after_tomorrow, category: :temperature, value: "27-31°C")
  end

  def and_i_see_predicted_uv_level_v2
    expect_prediction_v2(category: "ultraviolet-rays-uv", value: "Low")
  end

  def then_i_see_that_the_tomorrow_tab_is_active
    expect(page).to have_css(".tab.tomorrow.active")

    expect(page).not_to have_css(".tab.today.active")
    expect(page).not_to have_css(".tab.day_after_tomorrow.active")
  end

  def and_i_see_that_the_today_tab_is_active
    expect(page).to have_css(".tab.today.active")

    expect(page).not_to have_css(".tab.tomorrow.active")
    expect(page).not_to have_css(".tab.day_after_tomorrow.active")
  end

  def then_i_see_that_the_day_after_tomorrow_tab_is_active
    expect(page).to have_css(".tab.day_after_tomorrow.active")

    expect(page).not_to have_css(".tab.today.active")
    expect(page).not_to have_css(".tab.tomorrow.active")
  end

  def and_i_see_predicted_uv_level_for_tomorrow
    expect_styled_prediction(category: :"ultraviolet-rays-uv", level: :moderate)
  end

  def and_i_see_predicted_pollen_level_for_tomorrow
    expect_styled_prediction(category: :pollen, level: :moderate)
  end

  def and_i_see_predicted_temperature_level_for_tomorrow
    expect_styled_prediction(category: :temperature, level: :moderate)
  end

  def and_i_see_predicted_uv_level_for_day_after_tomorrow
    expect_styled_prediction(category: :"ultraviolet-rays-uv", level: :high)
  end

  def and_i_see_predicted_pollen_level_for_day_after_tomorrow
    expect_styled_prediction(category: :pollen, level: :high)
  end

  def and_i_see_predicted_temperature_level_for_day_after_tomorrow
    expect_styled_prediction(category: :temperature, level: :high)
  end

  def and_i_see_predicted_pollen_level_v2
    expect_prediction_v2(category: :pollen, value: "Low")
  end

  def and_i_see_predicted_temperature_level_v2
    expect_prediction_v2(category: :temperature, value: "-5°C - 4°C")
  end

  def expect_prediction(day:, category:, value:)
    within(prediction_category(category)) do
      within("td[data-date='#{date(day)}']") do
        expect(page).to have_content(content_for(category: category, value: value))
      end
    end
  end

  def expect_prediction_v2(category:, value:)
    within(".#{category}") do
      find("dd", text: value)
    end
  end

  def expect_styled_prediction(category:, level:)
    within(".#{category}") do
      expect_styled_content_for(category:, level:)
    end
  end

  def expect_styled_content_for(category:, level:)
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
    when :moderate
      expect(page).to have_content("9°C - 16°C")
    when :high
      expect(page).to have_content("27°C - 31°C")
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
