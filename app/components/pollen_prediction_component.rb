# frozen_string_literal: true

class PollenPredictionComponent < PredictionComponent
  def name
    "Pollen"
  end

  def level_label
    case @value
    when -999
      "Low"
    when 1..3
      "Low"
    when 4..6
      "Moderate"
    when 7..9
      "High"
    else
      "Very high"
    end
  end

  def guidance
    {
      low: "Pollen guidance for *low* DAQI level",
      moderate: "Pollen guidance for *moderate* DAQI level",
      high: "Pollen guidance for *high* DAQI level",
      very_high: "Pollen guidance for *very high* DAQI level"
    }
  end
end
