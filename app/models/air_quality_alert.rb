class AirQualityAlert
  def initialize(forecast:)
    @forecast = forecast
  end

  def date
    @forecast.date
  end

  def daqi_label
    @forecast.air_pollution[:label]
  end

  def value
    @forecast.air_pollution[:total]
  end
end
