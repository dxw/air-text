# frozen_string_literal: true

RSpec.feature "Health advice page" do
  describe "Visit the health advice page" do
    it "should display the health advice page" do
      visit "health_advice"
      expect(page).to have_content "Health advice"
    end
  end
end
