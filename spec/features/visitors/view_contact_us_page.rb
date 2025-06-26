# frozen_string_literal: true

RSpec.feature "Contact us page" do
  before do
    forecasts = [
      Fixtures::API.zone_forecast(day: :today),
      Fixtures::API.zone_forecast(day: :tomorrow),
      Fixtures::API.zone_forecast(day: :day_after_tomorrow)
    ]
    HttpStubs.stub_forecasts_api_with(forecasts)
  end

  describe "Visit the contact us page" do
    it "should display the contact us page" do
      visit "contact"
      expect(page).to have_content "Contact us"
    end

    it "is accessible", js: true do
      visit "contact"
      expect(page).to be_accessible
    end
  end
end
