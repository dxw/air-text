# frozen_string_literal: true

RSpec.feature "Air quality alerts page" do
  describe "Visit the air quality alerts page" do
    context "when there are no alerts" do
      before do
        forecasts = [
          Fixtures::API.zone_forecast(day: :today),
          Fixtures::API.zone_forecast(day: :tomorrow),
          Fixtures::API.zone_forecast(day: :day_after_tomorrow)
        ]
        HttpStubs.stub_cerc_api_with(forecasts)
      end

      it "should display a message" do
        visit alerts_path
        expect(page).to have_content "No alerts forecast for this area within the next 3 days."
      end

      it "is accessible", js: true do
        visit alerts_path
        expect(page).to be_accessible
      end
    end

    context "when there are alerts" do
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
        HttpStubs.stub_cerc_api_with(forecasts)
      end

      it "should display the alerts" do
        visit alerts_path
        expect(page).to have_content "High"
        expect(page).to have_content "Moderate"
        expect(page).to have_content "Very high"
      end

      it "is accessible", js: true do
        visit alerts_path
        expect(page).to be_accessible
      end
    end
  end
end
