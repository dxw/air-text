class DayTabComponent < ViewComponent::Base
  def initialize(forecast:, day:, active: false)
    @forecast = forecast
    @day = day
    @active = active
  end

  def daqi_indicator_colour_class
    "daqi-level-#{@forecast.air_pollution[:total]}"
  end

  def icon_stroke_colour_class
    ["HIGH", "VERY HIGH"].include?(@forecast.air_pollution[:label]) ? "stroke-white" : "stroke-black"
  end
end
