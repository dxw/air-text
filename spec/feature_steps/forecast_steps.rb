module ForecastSteps
  def given_a_forecast_for_today
    forecasts << Fixtures.build_forecast(day: :today, air_pollution_status: :high)
  end

  def and_a_forecast_for_tomorrow
    forecasts << Fixtures.build_forecast(day: :tomorrow, air_pollution_status: :moderate)
  end

  def and_a_forecast_for_the_day_after_tomorrow
    forecasts << Fixtures.build_forecast(day: :day_after_tomorrow, air_pollution_status: :very_high)
  end

  def forecasts
    @forecasts ||= []
  end

  def and_the_response_from_cercs_api_is_stubbed_accordingly
    forecast_response = Fixtures.forecast_wrapper_around(@forecasts)
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

  def expect_prediction(day:, category:, value:)
    within(prediction_category(category)) do
      within("td[data-date='#{date(day)}']") do
        expect(page).to have_content(content_for(category: category, value: value))
      end
    end
  end

  def prediction_category(category)
    case category
    when :air_pollution
      ".air-pollution"
    else
      NotImplementedError("We need to extend to handle the category #{category}")
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
    case category
    when :air_pollution
      content_for_air_pollution(value)
    else
      NotImplementedError("We need to extend for content for category #{category}")
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
end
