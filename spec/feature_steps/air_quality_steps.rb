module AirQualitySteps
  def given_an_air_pollution_prediction_for_today_w_high_warning_status
    forecasts << Fixtures::API.build_forecast(day: :today, air_pollution_status: :high)
  end

  def and_an_air_pollution_prediction_for_tomorrow_w_moderate_warning_status
    forecasts << Fixtures::API.build_forecast(day: :tomorrow, air_pollution_status: :moderate)
  end

  def and_an_air_pollution_prediction_for_day_after_tomorrow_w_v_high_warning_status
    forecasts << Fixtures::API.build_forecast(day: :day_after_tomorrow, air_pollution_status: :very_high)
  end

  def given_an_air_pollution_prediction_for_today_w_low_status
    forecasts << Fixtures::API.build_forecast(day: :today, air_pollution_status: :low)
  end

  def and_an_air_pollution_prediction_for_tomorrow_w_low_warning_status
    forecasts << Fixtures::API.build_forecast(day: :tomorrow, air_pollution_status: :low)
  end

  def and_an_air_pollution_prediction_for_day_after_tomorrow_w_low_warning_status
    forecasts << Fixtures::API.build_forecast(day: :day_after_tomorrow, air_pollution_status: :low)
  end

  def when_i_look_at_the_forecasts
    visit root_path
    click_link("View forecasts")
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
      "MODERATE"
    when :high
      "HIGH"
    when :very_high
      "VERY HIGH"
    end

    expect(page).to have_css(".alert-level", text: label)
  end

  def expect_to_see_guidance_for(level)
    expect(page).to have_content(I18n.t("air_quality_alert.#{level}.guidance.title"))
    expect(page).to have_content(
      ActionController::Base.helpers.strip_tags(
        I18n.t("air_quality_alert.#{level}.guidance.detail_html")
      )
    )
  end

  def then_i_see_an_air_quality_alert_of_high_for_today
    within(".alert-level-high[data-alert-date='#{Date.today}']") do
      expect_to_see_alert_date_for(:today)
      expect_to_see_alert_level(:high)
      expect_to_see_guidance_for(:high)
    end
  end

  def and_i_see_an_air_quality_alert_of_moderate_for_tomorrow
    within(".alert-level-moderate[data-alert-date='#{Date.tomorrow}']") do
      expect_to_see_alert_date_for(:tomorrow)
      expect_to_see_alert_level(:moderate)
      expect_to_see_guidance_for(:moderate)
    end
  end

  def and_i_see_an_air_quality_alert_of_v_high_for_day_after_tomorrow
    within(".alert-level-very-high[data-alert-date='#{Date.tomorrow + 1.day}']") do
      expect_to_see_alert_date_for(:day_after_tomorrow)
      expect_to_see_alert_level(:very_high)
      expect_to_see_guidance_for(:very_high)
    end
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
    forecast_response = Fixtures::API.forecast_wrapper_around(@forecasts)
    HttpStubs.stub_forecasts_with(forecast_response)
  end
end
