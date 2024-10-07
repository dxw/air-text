class UvPrediction
  attr_reader :value

  def initialize(value)
    @value = value
  end

  DAQI_LABELS = {
    low: "Low",
    moderate: "Moderate",
    high: "High",
    very_high: "Very high"
  }

  def daqi_label
    DAQI_LABELS.fetch(daqi_level)
  end

  def daqi_level
    case @value
    when 1..3
      :low
    when 4..6
      :moderate
    when 7..9
      :high
    else
      :very_high
    end
  end

  def guidance
    I18n.t("prediction.guidance.uv.#{daqi_level}")
  end

  # :nocov:
  def inspect
    "#<#{self.class.name} @value=#{value}>"
  end
end
