class DayTabComponent < ViewComponent::Base
  def initialize(forecast:, day:)
    @forecast = forecast
    @day = day
  end

  TAG_COLOURS = {
    1 => "bg-lime-400",
    2 => "bg-green-400",
    3 => "bg-lime-600",
    4 => "bg-yellow-300",
    5 => "bg-amber-200",
    6 => "bg-yellow-500",
    7 => "bg-orange-500",
    8 => "bg-red-500",
    9 => "bg-red-800",
    10 => "bg-stone-700"
  }

  def daqi_indicator_colour_class
    TAG_COLOURS.fetch(@forecast.air_pollution.value)
  end

  def classes
    if @day == :today
      "active daqi-level-#{@forecast.air_pollution.value}-today"
    else
      "inactive after-today"
    end
  end
end
