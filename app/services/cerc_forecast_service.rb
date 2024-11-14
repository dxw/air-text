class CercForecastService
  class << self
    def latest_forecasts_for(zone)
      refresh_cache if CachedForecast.stale?

      CachedForecast.latest_for(zone)
    end

    private

    def refresh_cache
      cerc_forecasts = CercApiClient.latest_forecasts
      obtained_at = Time.zone.parse(cerc_forecasts.fetch("forecastdate"))

      cerc_forecasts.fetch("zones").each do |zone|
        CachedForecast.store(
          zone_forecasts(zone, obtained_at: obtained_at)
        )
      end
    end

    def zone_forecasts(zone, obtained_at: Time.current)
      zone["forecasts"].map do |forecast|
        Forecast.new({
          obtained_at: obtained_at,
          date: Date.parse(forecast.fetch("forecast_date")),

          zone: ForecastZone.new(
            id: zone.fetch("zone_id"),
            name: zone.fetch("zone_name"),
            type: zone.fetch("zone_type")
          ),

          air_pollution: AirPollutionPrediction.new(
            forecasted_at: Time.zone.parse(forecast.fetch("pollution_version").to_s),
            nitrogen_dioxide: forecast.fetch("NO2"),
            particulate_matter_10: forecast.fetch("PM10"),
            particulate_matter_2_5: forecast.fetch("PM2.5"),
            ozone: forecast.fetch("O3"),
            value: forecast.fetch("total"),
            label: forecast.fetch("total_status")
          ),

          uv: UvPrediction.new(value: forecast.fetch("uv")),
          pollen: PollenPrediction.new(value: forecast.fetch("pollen")),
          temperature: TemperaturePrediction.new(
            min: forecast.fetch("temp_min"),
            max: forecast.fetch("temp_max")
          )
        })
      end
    end
  end
end
