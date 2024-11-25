class ForecastsController < ApplicationController
  def show
    @maptiler_api_key = ENV.fetch("MAPTILER_API_KEY")
    @zone = zone
    @date = date
    @day = @date ? day_from_date(@date) : params.fetch("day", "today")
    @pollutant = params.fetch("pollutant", "Total")
    @map_lat = params.fetch("lat", nil)
    @map_lon = params.fetch("lon", nil)
    @map_zoom = params.fetch("zoom", nil)

    @forecasts = CercForecastService.latest_forecasts_for(zone).data
    @day_forecast = forecast_for_day(@day, @forecasts)
  end

  private

  def day_from_date(date)
    if date <= Date.today
      "today"
    elsif date == Date.tomorrow
      "tomorrow"
    elsif date >= Date.tomorrow
      "day_after_tomorrow"
    end
  end

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

    Zone.find_by(name: params[:zone])
  end

  def date
    Date.parse(params.fetch("date")) if params[:date].present?
  rescue ArgumentError
    Date.today # default to today
  end
end
