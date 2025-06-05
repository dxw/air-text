RSpec.feature "Forecasts page - air quality alerts" do
  include Features::ForecastPageHelper

  before do
    forecasts = [
      Fixtures::API.zone_forecast(
        day: :today,
        air_pollution_status: :high
      ),
      Fixtures::API.zone_forecast(
        day: :tomorrow,
        air_pollution_status: :moderate,
        daqi_value: 4
      ),
      Fixtures::API.zone_forecast(
        day: :day_after_tomorrow,
        air_pollution_status: :very_high,
        daqi_value: 10
      )
    ]
    HttpStubs.stub_forecasts_api_with(forecasts)
  end

  describe "View air quality alert for today" do
    it "shows an air quality alert of high for today" do
      visit forecast_path
      tab_selector = ".tab[data-date='#{Date.today}']"

      within(tab_selector) do
        expect_to_see_alert_level("High")
      end
      within(".alert-guidance") do
        expect_to_see_guidance_for(:high)
      end
    end
  end

  describe "View air quality alert for tomorrow", js: true do
    it "shows an air quality alert of moderate for tomorrow" do
      visit forecast_path
      tab_selector = ".tab[data-date='#{Date.tomorrow}']"
      find(tab_selector).click

      within(tab_selector) do
        expect_to_see_alert_level("Moderate")
      end
      within(".alert-guidance") do
        expect_to_see_guidance_for(:moderate)
      end
      expect(page).to have_css("#{tab_selector}.active")
      expect(page).not_to have_css(".tab.day_after_tomorrow.active")
    end
  end

  describe "View air quality alert for the day after tomorrow", js: true do
    it "shows an air quality alert of very high for the day after tomorrow" do
      visit forecast_path
      tab_selector = ".tab[data-date='#{Date.tomorrow + 1.day}']"
      find(tab_selector).click

      within(tab_selector) do
        expect_to_see_alert_level("Very high")
      end
      within(".alert-guidance") do
        expect_to_see_guidance_for(:very_high)
      end
      expect(page).to have_css("#{tab_selector}.active")
      expect(page).not_to have_css(".tab.tomorrow.active")
    end
  end
end
