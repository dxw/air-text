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

          zone: {
            id: zone.fetch("zone_id"),
            name: zone.fetch("zone_name"),
            type: zone.fetch("zone_type")
          },

          air_pollution: {
            forecasted_at: Time.zone.parse(forecast.fetch("pollution_version").to_s),
            no2: forecast.fetch("NO2"),
            pm10: forecast.fetch("PM10"),
            pm2_5: forecast.fetch("PM2.5"),
            o3: forecast.fetch("O3"),
            total: forecast.fetch("total"),
            label: forecast.fetch("total_status")
          },

          uv: forecast.fetch("uv"),
          pollen: forecast.fetch("pollen"),
          temperature: {
            min: forecast.fetch("temp_min"),
            max: forecast.fetch("temp_max")
          }
        })
      end
    end
  end
end
