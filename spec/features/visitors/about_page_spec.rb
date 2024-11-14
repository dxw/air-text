# frozen_string_literal: true

RSpec.feature "About page" do
  describe "Visit the about page" do
    it "should display the about page" do
      visit "about"
      expect(page).to have_content "About airTEXT"
    end
  end
end
