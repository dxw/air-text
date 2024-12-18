class DayTabComponent < ViewComponent::Base
  def initialize(forecast:, active_date:)
    @forecast = forecast
    @active = active_date == forecast.date
  end

  def daqi_indicator_colour_class
    "daqi-level-#{@forecast.air_pollution[:total]}"
  end

  def icon_stroke_colour_class
    ["HIGH", "VERY HIGH"].include?(@forecast.air_pollution[:label]) ? "stroke-white" : "stroke-black"
  end
end
