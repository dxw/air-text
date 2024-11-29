# frozen_string_literal: true

RSpec.feature "Forecasts page", feature: true do
  include Features::ForecastHelper

  describe "Viewing forecasts" do
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
        stub_cerc_api_with(forecasts)
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
        expect(page).to have_content("Air quality forecast")

        # Today tab is active
        expect(page).to have_css(".tab.today.active")

        expect(page).to have_css(".tab.tomorrow.inactive")
        expect(page).to have_css(".tab.day_after_tomorrow.inactive")

        expect(page).not_to have_css(".tab.tomorrow.active")
        expect(page).not_to have_css(".tab.day_after_tomorrow.active")

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
        switch_to_tab_for(:tomorrow)

        # See that the tomorrow tab is active
        expect(page).to have_css(".tab.tomorrow.active")

        expect(page).to have_css(".tab.today.inactive")
        expect(page).to have_css(".tab.day_after_tomorrow.inactive")

        expect(page).not_to have_css(".tab.today.active")
        expect(page).not_to have_css(".tab.day_after_tomorrow.active")

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
        switch_to_tab_for(:day_after_tomorrow)

        # See that the day after tomorrow tab is active
        expect(page).to have_css(".tab.day_after_tomorrow.active")

        expect(page).to have_css(".tab.today.inactive")
        expect(page).to have_css(".tab.tomorrow.inactive")

        expect(page).not_to have_css(".tab.today.active")
        expect(page).not_to have_css(".tab.tomorrow.active")

        # Predicted UV level for the day after tomorrow
        expect_prediction(category: :uv, level: :high)

        # Predicted pollen level for the day after tomorrow
        expect_prediction(category: :pollen, level: :high)

        # Predicted temperature level for the day after tomorrow
        expect_prediction(category: :temperature, level: :high)
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
          stub_cerc_api_with(forecasts)
        end

        it "shows the pollen prediction" do
          visit forecast_path

          expect(page).to have_css(".pollen")
        end
      end
    end
  end
end
