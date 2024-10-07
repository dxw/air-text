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
    @forecast.forecast_for
  end

  def level
    @forecast.air_pollution.overall_label
  end

  def score
    @forecast.air_pollution.overall_score
  end

  def tag_colour
    TAG_COLOURS.fetch(
      ActiveSupport::Inflector.parameterize(level, separator: "_").to_sym
    )
  end
end
