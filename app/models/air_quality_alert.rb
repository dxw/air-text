class AirQualityAlert
  def initialize(forecast)
    @forecast = forecast
  end

  TAG_COLOURS = {
    moderate: :yellow,
    high: :red,
    very_high: :purple
  }

  def date
    @forecast.date
  end

  def daqi_level
    @forecast.air_pollution.daqi_level
  end

  def daqi_label
    @forecast.air_pollution.daqi_label
  end

  def value
    @forecast.air_pollution.value
  end

  def tag_colour
    TAG_COLOURS.fetch(daqi_level)
  end
end
