# Feature: View air quality alerts
#   - So that I can take appropriate protective action
#   - As a visitor
#   - I want to see Air quality alerts for air pollution predictions with warning
#       statuses above "low"
RSpec.feature "Air quality alerts" do
  around do |example|
    env_vars = {
      CERC_API_HOST_URL: "https://cerc.example.com",
      CERC_API_KEY: "SECRET-API-KEY"
    }
    ClimateControl.modify(env_vars) { example.run }
  end

  include AirQualitySteps

  scenario "View air quality alerts" do
    given_an_air_pollution_prediction_for_today_w_high_warning_status
    and_an_air_pollution_prediction_for_tomorrow_w_moderate_warning_status
    and_an_air_pollution_prediction_for_day_after_tomorrow_w_v_high_warning_status
    and_the_response_from_cercs_api_is_stubbed_accordingly

    when_i_look_at_the_forecasts
    then_i_see_an_air_quality_alert_of_high_for_today
    and_i_see_an_air_quality_alert_of_moderate_for_tomorrow
    and_i_see_an_air_quality_alert_of_v_high_for_day_after_tomorrow
  end

  scenario "See confirmation that there are current no air quality alert" do
    given_an_air_pollution_prediction_for_today_w_low_status
    and_an_air_pollution_prediction_for_tomorrow_w_low_warning_status
    and_an_air_pollution_prediction_for_day_after_tomorrow_w_low_warning_status
    and_the_response_from_cercs_api_is_stubbed_accordingly

    when_i_look_at_the_forecasts
    then_i_see_that_there_are_no_current_air_quality_alerts
  end
end
