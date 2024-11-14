class DayTabComponent < ViewComponent::Base
  def initialize(forecast:, day:, selected_day:)
    @forecast = forecast
    @day = day
    @selected_day = selected_day
    @zone = forecast.zone
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

  def daqi_tab_class
    if @day == "today"
      "daqi-level-#{@forecast.air_pollution.value}-today"
    elsif @forecast.alerts && @day == @selected_day
      "daqi-alert-after-today-selected-level-#{@forecast.air_pollution.value}"
    else
      "after-today"
    end
  end

  def active_tab_class
    if @day == @selected_day
      "active"
    else
      "inactive"
    end
  end

  def tab_classes
    "#{daqi_tab_class} #{active_tab_class}"
  end
end
