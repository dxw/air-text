class ForecastsController < ApplicationController
  def show
    @selected_day = selected_day
    @zone = zone

    @maptiler_api_key = ENV.fetch("MAPTILER_API_KEY")
    @forecasts = CercForecastService.latest_forecasts_for(@zone).data
    @day_forecast = forecast_for_day(@selected_day, @forecasts)
  end

  def update
    @selected_day = selected_day
    @zone = zone

    @maptiler_api_key = ENV.fetch("MAPTILER_API_KEY")
    @forecasts = CercForecastService.latest_forecasts_for(@zone).data

    @day_forecast = forecast_for_day(@selected_day, @forecasts)

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
    end
  end

  def zone
    if params[:zone]
      Zone.find_by(name: params[:zone]) || Zone.default
    else
      Zone.default
    end
  end

  def selected_day
    if ["today", "tomorrow", "day_after_tomorrow"].include?(params[:day])
      params[:day]
    else
      "today"
    end
  end
end
