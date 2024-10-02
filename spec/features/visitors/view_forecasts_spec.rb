# frozen_string_literal: true

# Feature: Forecasts page
#   So that I can understand potential health dangers in my area
#   As a visitor who has chosen a particular zone
#   I want to see warnings and alerts for both pollutants and non-pollutants for 3 days
RSpec.feature "Forecasts page" do
  around do |example|
    env_vars = {
      CERC_API_HOST_URL: "https://cerc.example.com",
      CERC_API_KEY: "SECRET-API-KEY"
    }
    ClimateControl.modify(env_vars) { example.run }
  end

  include ForecastSteps

  scenario "See forecasts for 3 days" do
    given_a_forecast_for_today
    and_a_forecast_for_tomorrow
    and_a_forecast_for_the_day_after_tomorrow
    and_the_response_from_cercs_api_is_stubbed_accordingly

    visit root_path
    when_i_select_view_forecasts
    then_i_see_the_forecasts_page
    and_i_see_local_air_quality_information
    and_i_see_predicted_air_pollution_status_for_each_day
  end
end
