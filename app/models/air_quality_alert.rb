class AirQualityAlert
  def initialize(forecast)
    @forecast = forecast
  end

  def date
    @forecast.forecast_for
  end

  def level
    @forecast.air_pollution.overall_label
  end

  def score
    @forecast.air_pollution.overall_score
  end
end
