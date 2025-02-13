class DayTabComponent < ViewComponent::Base
  def initialize(forecast:, active_date:)
    @forecast = forecast
    @active = active_date == forecast.date
  end

  def daqi_indicator_colour_class
    "daqi-level-#{@forecast.air_pollution[:total]} daqi-label-#{@forecast.air_pollution[:label].parameterize}"
  end
end
