# frozen_string_literal: true

class UvPredictionComponent < PredictionComponent
  def name
    "Ultraviolet rays (UV)"
  end

  def css_name
    "uv"
  end

  def level_label
    case @value
    when 1..2
      "Low"
    when 3..5
      "Moderate"
    when 6..7
      "High"
    when 8..10
      "Very high"
    end
  end

  def guidance
    {
      low: "No action required. You can safely stay outside.",
      moderate:
        "Protection required. Seek shade during midday hours, cover up and wear suncream.",
      high: "UV guidance for *high* DAQI level",
      very_high: "UV guidance for *very high* DAQI level"
    }
  end
end
