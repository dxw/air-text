class StyledForecastsController < ApplicationController
  layout "tailwind_layout"
  def show
    @forecasts = CercApiClient
      .forecasts_for(params.fetch("zone", "Southwark"))
  end

  def update
    forecasts = CercApiClient
      .forecasts_for(params.fetch("zone", "Southwark"))

    day_forecast = forecast_for_day(params.fetch("day"), forecasts)

    render turbo_stream: turbo_stream.replace("day_predictions", partial: "predictions", locals: {forecast: day_forecast})
  end

  def forecast_for_day(day, forecasts)
    case day
    when "today"
      forecasts.first
    when "tomorrow"
      forecasts.second
    when "day_after_tomorrow"
      forecasts.third
    end
  end
end
