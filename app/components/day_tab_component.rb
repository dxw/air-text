class DayTabComponent < ViewComponent::Base
  def initialize(forecast:, day:, active: false)
    @forecast = forecast
    @day = day
    @active = active
  end

  def daqi_indicator_colour_class
    "daqi-level-#{@forecast.air_pollution.value}"
  end
end
