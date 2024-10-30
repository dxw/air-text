class StyledForecastsController < ApplicationController
  layout "tailwind_layout"
  def show
    @forecasts = CercForecastService.latest_forecasts_for(zone).data
  end

  def update
    forecasts = CercForecastService.latest_forecasts_for(zone).data

    day_forecast = forecast_for_day(params.fetch("day"), forecasts)

    render turbo_stream: turbo_stream.replace(
      "day_predictions",
      partial: "predictions",
      locals: {forecast: day_forecast}
    )
  end

  private

  def forecast_for_day(day, forecasts)
    case day
    when "today"
      forecasts.first
    when "tomorrow"
      forecasts.second
    when "day_after_tomorrow"
      forecasts.third
    else
      raise ArgumentError, "Invalid day: #{day}"
    end
  end

  def zone
    return Zone.default unless params[:zone]

    Zone.find_by(cerc_id: params[:zone])
  end
end
