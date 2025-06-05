# frozen_string_literal: true

RSpec.feature "Terms and conditions page" do
  before do
    forecasts = [
      Fixtures::API.zone_forecast(day: :today),
      Fixtures::API.zone_forecast(day: :tomorrow),
      Fixtures::API.zone_forecast(day: :day_after_tomorrow)
    ]
    HttpStubs.stub_cerc_api_with(forecasts)
  end

  describe "Visit the terms and conditions page" do
    it "should display the terms and conditions page" do
      visit "terms_and_conditions"
      expect(page).to have_content "Terms and conditions"
    end

    it "is accessible", js: true do
      visit "terms_and_conditions"
      expect(page).to be_accessible
    end
  end
end
