# frozen_string_literal: true

RSpec.feature "Health advice page" do
  before do
    forecasts = [
      Fixtures::API.zone_forecast(day: :today),
      Fixtures::API.zone_forecast(day: :tomorrow),
      Fixtures::API.zone_forecast(day: :day_after_tomorrow)
    ]
    HttpStubs.stub_cerc_api_with(forecasts)
  end

  describe "Visit the health advice page" do
    it "should display the health advice page" do
      visit "health_advice"
      expect(page).to have_content "Health guidance"
    end

    it "is accessible", js: true do
      visit "health_advice"
      expect(page).to be_accessible
    end
  end
end
