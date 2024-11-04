# Feature: View air quality alerts
#   - So that I can take appropriate protective action
#   - As a visitor
#   - I want to see Air quality alerts for air pollution predictions with warning
#       statuses above "low"
RSpec.feature "Air quality alerts", feature: true do
  around do |example|
    env_vars = {
      CERC_API_HOST_URL: "https://cerc.example.com",
      CERC_API_KEY: "SECRET-API-KEY",
      CERC_API_CACHE_LIMIT_MINS: "60",
      MAPTILER_API_KEY: "TOPSECRET"
    }
    ClimateControl.modify(env_vars) { example.run }
  end

  include AirQualitySteps, ForecastSteps

  before do
    given_an_air_pollution_prediction_for_today_w_high_warning_status
    and_an_air_pollution_prediction_for_tomorrow_w_moderate_warning_status
    and_an_air_pollution_prediction_for_day_after_tomorrow_w_v_high_warning_status
    and_the_response_from_cercs_api_is_stubbed_accordingly
  end

  scenario "View air quality alert for today" do
    when_i_look_at_the_forecasts
    then_i_see_an_air_quality_alert_of_high_for_today
  end

  scenario "View air quality alert for tomorrow", js: true do
    visit root_path
    when_i_select_view_forecasts
    and_i_switch_to_the_tab_for_tomorrow

    then_i_see_an_air_quality_alert_of_moderate_for_tomorrow
  end

  scenario "View air quality alert for the day after tomorrow", js: true do
    visit root_path
    when_i_select_view_forecasts
    and_i_switch_to_the_tab_for_day_after_tomorrow

    then_i_see_an_air_quality_alert_of_v_high_for_day_after_tomorrow
  end
end
