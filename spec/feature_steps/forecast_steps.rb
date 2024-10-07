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

  def then_i_see_the_forecasts_page
    expect(page).to have_content("Forecasts")
  end

  def and_i_see_local_air_quality_information
    expect(page).to have_content("Three day forecast for Haringey")
  end

  def and_i_see_predicted_air_pollution_status_for_each_day
    expect_prediction(day: :today, category: :air_pollution, value: :high)
    expect_prediction(day: :tomorrow, category: :air_pollution, value: :moderate)
    expect_prediction(day: :day_after_tomorrow, category: :air_pollution, value: :very_high)
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

  def expect_prediction(day:, category:, value:)
    within(prediction_category(category)) do
      within("td[data-date='#{date(day)}']") do
        expect(page).to have_content(content_for(category: category, value: value))
      end
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
      "Low - No action required. You can safely stay outside."
    when :moderate
      "Moderate - Protection required. Seek shade during midday hours, cover up and wear suncream."
    when :high
      "High - some high UV guidance"
    when :very_high
      "Very high- some very high UV guidance"
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
