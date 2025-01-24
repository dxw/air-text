# frozen_string_literal: true

RSpec.feature "About page" do
  before do
    forecasts = [
      Fixtures::API.zone_forecast(day: :today),
      Fixtures::API.zone_forecast(day: :tomorrow),
      Fixtures::API.zone_forecast(day: :day_after_tomorrow)
    ]
    HttpStubs.stub_cerc_api_with(forecasts)
  end

  describe "Visit the about page" do
    it "should display the about page" do
      visit "about"
      expect(page).to have_content "About airTEXT"
    end

    it "is accessible", js: true do
      visit "about"
      expect(page).to be_accessible
    end
  end
end
