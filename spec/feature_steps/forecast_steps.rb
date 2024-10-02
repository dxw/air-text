module ForecastSteps
  def given_a_forecast_for_today
    forecasts << Fixtures.build_forecast(day: :today, air_pollution_status: :high)
  end

  def and_a_forecast_for_tomorrow
    forecasts << Fixtures.build_forecast(day: :tomorrow, air_pollution_status: :moderate)
  end

  def and_a_forecast_for_the_day_after_tomorrow
    forecasts << Fixtures.build_forecast(day: :day_after_tomorrow, air_pollution_status: :very_high)
  end

  def forecasts
    @forecasts ||= []
  end

  def and_the_response_from_cercs_api_is_stubbed_accordingly
    forecast_response = Fixtures.forecast_wrapper_around(@forecasts)
    HttpStubs.stub_forecasts_with(forecast_response)
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
