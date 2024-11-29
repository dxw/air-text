# frozen_string_literal: true

class TemperaturePredictionComponent < PredictionComponent
  def name
    "Temperature"
  end

  def display_value
    "#{values[:min_c].round}&nbsp;to&nbsp;#{values[:max_c].round}°C / #{values[:min_f].round}&nbsp;to&nbsp;#{values[:max_f].round}°F"
  end

  def guidance
    {
      low_temp: "Temperature guidance for *low*",
      high_temp: "Temperature guidance for *high*"
    }
  end

  def values
    {
      min_c: @value[:min],
      max_c: @value[:max],
      min_f: farenheit(@value[:min]),
      max_f: farenheit(@value[:max])
    }
  end

  def farenheit(celsius)
    (celsius * 9 / 5) + 32
  end

  def guidance_visible?
    @value[:min] < 2 || @value[:max] > 25
  end

  def guidance_text
    return guidance[:low_temp] if @value[:min] <= 2
    guidance[:high_temp] if @value[:max] >= 25
  end

  def guidance_panel_colour
    "bg-high-alert-guidance-panel"
  end
end
