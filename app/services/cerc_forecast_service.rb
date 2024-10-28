class CercForecastService
  class << self
    def latest_forecasts_for(zone)
      if CachedForecast.stale?
        cerc_forecasts = CercApiClient.latest_forecasts

        cerc_forecasts.fetch("zones").each do |zone|
          CachedForecast.store(
            ForecastFactory.build(
              cerc_forecasts: cerc_forecasts, zone_id: zone.fetch("zone_id")
            )
          )
        end
      else
        CachedForecast.latest_for(zone)
      end
    end
  end
end
