# frozen_string_literal: true

RSpec.feature "Forecasts page" do
  include Features::ForecastPageHelper

  describe "Viewing forecasts" do
    tab_selector_today = ".tab[data-date='#{Date.today}']"
    tab_selector_tomorrow = ".tab[data-date='#{Date.tomorrow}']"
    tab_selector_day_after_tomorrow = ".tab[data-date='#{Date.tomorrow + 1.day}']"

    describe "Viewing forecasts for 3 days" do
      before do
        forecasts = [
          # Given the forecasts for today, tomorrow and the day after tomorrow
          Fixtures::API.zone_forecast(
            day: :today,
            air_pollution_status: :high,
            pollen: :low,
            temperature: :cold,
            uv: :low
          ),
          Fixtures::API.zone_forecast(
            day: :tomorrow,
            air_pollution_status: :moderate,
            pollen: :moderate,
            temperature: :normal,
            uv: :moderate
          ),
          Fixtures::API.zone_forecast(
            day: :day_after_tomorrow,
            air_pollution_status: :very_high,
            pollen: :high,
            temperature: :hot,
            uv: :high
          )
        ]
        HttpStubs.stub_forecasts_api_with(forecasts)
      end

      it "shows the forecasts for today, tomorrow and the day after tomorrow" do
        ##
        # When I select view forecasts
        #
        # Then I see the forecasts page
        # and I see that the today tab is active
        # and I see predicted air pollution status for each day
        # and I see predicted uv level
        # and I see predicted pollen level
        # and I see predicted temperature level
        ##

        visit forecast_path

        # See the forecasts page
        expect(page).to have_content("Air pollution forecast")

        # Today tab is active
        expect(page).to have_css("#{tab_selector_today}.active")

        expect(page).to have_css("#{tab_selector_tomorrow}.inactive")
        expect(page).to have_css("#{tab_selector_day_after_tomorrow}.inactive")

        expect(page).not_to have_css("#{tab_selector_tomorrow}.active")
        expect(page).not_to have_css("#{tab_selector_day_after_tomorrow}.active")

        # Air pollution status for each day
        expect_air_pollution_prediction(day: :today, value: :high)
        expect_air_pollution_prediction(day: :tomorrow, value: :moderate)
        expect_air_pollution_prediction(day: :day_after_tomorrow, value: :very_high)

        # UV level
        expect_prediction(category: :uv, level: :low)

        # Pollen level
        expect_prediction(category: :pollen, level: :low)

        # Temperature level
        expect_prediction(category: :temperature, level: :low)
      end

      it "shows details for tomorrow", js: true do
        ##
        # When I select view forecasts
        # And I switch to the tab for tomorrow
        #
        # Then I see that the tomorrow tab is active
        # And I see predicted UV level for the day after tomorrow
        # And I see predicted pollen level for tomorrow
        # And I see predicted temperature level for tomorrow
        ##

        visit forecast_path
        tab_selector_today = ".tab[data-date='#{Date.today}']"
        tab_selector_tomorrow = ".tab[data-date='#{Date.tomorrow}']"
        tab_selector_day_after_tomorrow = ".tab[data-date='#{Date.tomorrow + 1.day}']"
        find(tab_selector_tomorrow).click

        # See that the tomorrow tab is active
        expect(page).to have_css("#{tab_selector_tomorrow}.active")

        expect(page).to have_css("#{tab_selector_today}.inactive")
        expect(page).to have_css("#{tab_selector_day_after_tomorrow}.inactive")

        expect(page).not_to have_css("#{tab_selector_today}.active")
        expect(page).not_to have_css("#{tab_selector_day_after_tomorrow}.active")

        # Predicted UV level for tomorrow
        expect_prediction(category: :uv, level: :moderate)

        # Predicted pollen level for tomorrow
        expect_prediction(category: :pollen, level: :moderate)

        # Predicted temperature level for tomorrow
        expect_prediction(category: :temperature, level: :moderate)
      end

      it "shows details for the day after tomorrow", js: true do
        ##
        # When I select view forecasts
        # And I switch to the tab for the day after tomorrow
        #
        # Then I see that the day after tomorrow tab is active
        # And I see predicted UV level for the day after tomorrow
        # And I see predicted pollen level for the day after tomorrow
        # And I see predicted temperature level for the day after tomorrow
        ##

        visit forecast_path
        find(tab_selector_day_after_tomorrow).click

        # See that the day after tomorrow tab is active
        expect(page).to have_css("#{tab_selector_day_after_tomorrow}.active")

        expect(page).to have_css("#{tab_selector_today}.inactive")
        expect(page).to have_css("#{tab_selector_tomorrow}.inactive")

        expect(page).not_to have_css("#{tab_selector_today}.active")
        expect(page).not_to have_css("#{tab_selector_tomorrow}.active")

        # Predicted UV level for the day after tomorrow
        expect_prediction(category: :uv, level: :high)

        # Predicted pollen level for the day after tomorrow
        expect_prediction(category: :pollen, level: :high)

        # Predicted temperature level for the day after tomorrow
        expect_prediction(category: :temperature, level: :high)
      end

      it "is accessible", js: true do
        visit forecast_path
        expect(page).to be_accessible
      end
    end

    describe "Viewing pollen prediction" do
      context "when the pollen level is a positive number" do
        before do
          forecasts = [
            Fixtures::API.zone_forecast(day: :today),
            Fixtures::API.zone_forecast(day: :tomorrow),
            Fixtures::API.zone_forecast(day: :day_after_tomorrow)
          ]
          HttpStubs.stub_forecasts_api_with(forecasts)
        end

        it "shows the pollen prediction" do
          visit forecast_path

          expect(page).to have_css(".pollen")
        end
      end
    end
  end
end
