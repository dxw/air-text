module AirQualitySteps
  def given_an_air_pollution_prediction_for_today_w_high_warning_status
    forecasts << Fixtures.build_forecast(day: :today, air_pollution_status: :high)
  end

  def and_an_air_pollution_prediction_for_tomorrow_w_moderate_warning_status
    forecasts << Fixtures.build_forecast(day: :tomorrow, air_pollution_status: :moderate)
  end

  def and_an_air_pollution_prediction_for_day_after_tomorrow_w_v_high_warning_status
    forecasts << Fixtures.build_forecast(day: :day_after_tomorrow, air_pollution_status: :very_high)
  end

  def given_an_air_pollution_prediction_for_today_w_low_status
    forecasts << Fixtures.build_forecast(day: :today, air_pollution_status: :low)
  end

  def and_an_air_pollution_prediction_for_tomorrow_w_low_warning_status
    forecasts << Fixtures.build_forecast(day: :tomorrow, air_pollution_status: :low)
  end

  def and_an_air_pollution_prediction_for_day_after_tomorrow_w_low_warning_status
    forecasts << Fixtures.build_forecast(day: :day_after_tomorrow, air_pollution_status: :low)
  end

  def when_i_look_at_the_forecasts
    visit root_path
    click_link("View forecasts")
  end

  def then_i_see_an_air_quality_alert_of_high_for_today
    within(".air-quality-alerts") do
      expect(page).to have_content("Air Quality Alert HIGH")
    end
  end

  def and_i_see_an_air_quality_alert_of_moderate_for_tomorrow
  end

  def and_i_see_an_air_quality_alert_of_v_high_for_day_after_tomorrow
  end

  def then_i_see_that_there_are_no_current_air_quality_alerts
    within(".air-quality-alerts") do
      expect(page).to have_content("No air quality alerts")
    end
  end

  def forecasts
    @forecasts ||= []
  end

  def and_the_response_from_cercs_api_is_stubbed_accordingly
    forecast_response = Fixtures.forecast_wrapper_around(@forecasts)
    HttpStubs.stub_forecasts_with(forecast_response)
  end
end
