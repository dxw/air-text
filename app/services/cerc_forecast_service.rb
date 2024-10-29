class CercForecastService
  class << self
    def latest_forecasts_for(zone)
      refresh_cache if CachedForecast.stale?

      CachedForecast.latest_for(zone)
    end

    def refresh_cache
      cerc_forecasts = CercApiClient.latest_forecasts

      cerc_forecasts.fetch("zones").each do |zone|
        CachedForecast.store(
          ForecastFactory.build(
            cerc_forecasts: cerc_forecasts, zone_id: zone.fetch("zone_id")
          )
        )
      end
    end
  end
end
