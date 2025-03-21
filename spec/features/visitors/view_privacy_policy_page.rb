# frozen_string_literal: true

RSpec.feature "Privacy policy page" do
  before do
    forecasts = [
      Fixtures::API.zone_forecast(day: :today),
      Fixtures::API.zone_forecast(day: :tomorrow),
      Fixtures::API.zone_forecast(day: :day_after_tomorrow)
    ]
    HttpStubs.stub_cerc_api_with(forecasts)
  end

  describe "Visit the privacy policy page" do
    it "should display the privacy policy page" do
      visit "privacy_policy"
      expect(page).to have_content "Privacy policy"
    end

    it "is accessible", js: true do
      visit "privacy_policy"
      expect(page).to be_accessible
    end
  end
end
