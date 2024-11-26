class ForecastsController < ApplicationController
  def show
    @maptiler_api_key = ENV.fetch("MAPTILER_API_KEY")
    @zone = zone
    @date = date
    @day = @date ? day_from_date(@date) : day
    @pollutant = pollutant
    @map_lat = params.fetch("lat", nil)
    @map_lon = params.fetch("lon", nil)
    @map_zoom = params.fetch("zoom", nil)

    @forecasts = CercForecastService.latest_forecasts_for(@zone).data
    @day_forecast = forecast_for_day(@day, @forecasts)
    @share_message = @day_forecast.share_message

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("forecasts-frame-top", partial: "forecasts/top"),
          turbo_stream.replace("forecasts-frame-bottom", partial: "forecasts/bottom")
        ]
      end
      format.html
    end
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

  def day
    return params.fetch("day") if %w[today tomorrow day_after_tomorrow].include?(params.dig("day"))

    "today" # default to today
  end

  def pollutant
    return params.fetch("pollutant", "Total") if %w[Total PM10 PM25 NO2 O3].include?(params.dig("pollutant"))

    "Total" # default to Total
  end
end
