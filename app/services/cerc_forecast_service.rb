class CercForecastService
  class << self
    def latest_forecasts_for(zone)
      if CachedForecast.stale?
        CercApiClient.latest_forecasts
      else
        CachedForecast.latest_for(zone)
      end
    end
  end
end
