class ForecastsController < ApplicationController
  def show
    @maptiler_api_key = ENV.fetch("MAPTILER_API_KEY")
    @forecasts = CercForecastService.latest_forecasts_for(zone).data
  end

  def update
    @maptiler_api_key = ENV.fetch("MAPTILER_API_KEY")
    forecasts = CercForecastService.latest_forecasts_for(zone).data

    @day_forecast = forecast_for_day(params.fetch("day"), forecasts)

    respond_to do |format|
      format.turbo_stream
    end
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
