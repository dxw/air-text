# frozen_string_literal: true

# Feature: Forecasts page
#   So that I can understand potential health dangers in my area
#   As a visitor who has chosen a particular zone
#   I want to see warnings and alerts for both pollutants and non-pollutants for 3 days
RSpec.feature "Forecasts page" do
  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   And I select "View forecasts"
  #   Then I see the forecasts page
  #   And I see local air quality information
  scenario "visit the forecasts page" do
    visit root_path
    when_i_select_view_forecasts
    then_i_see_the_forecasts_page
    and_i_see_local_air_quality_information
  end

  def when_i_select_view_forecasts
    click_link("View forecasts")
  end

  def then_i_see_the_forecasts_page
    expect(page).to have_content("Forecasts")
  end

  def and_i_see_local_air_quality_information
    expect(page).to have_content("Three day forecast for Haringey")
    within first(".govuk-table__row") do
      page.all("td").each_with_index do |td, index|
        if index == 0
          expect(td).to have_content("Air pollution")
        else
          expect(td).to have_content("Low")
        end
      end
    end
  end
end
