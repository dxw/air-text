class CercForecastService
  class << self
    def latest_forecasts_for(zone)
      CercApiClient.forecasts_for(zone)
    end
  end
end
