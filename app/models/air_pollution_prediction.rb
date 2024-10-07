class AirPollutionPrediction
  attr_reader :forecasted_at,
    :nitrogen_dioxide,
    :particulate_matter_10,
    :particulate_matter_2_5,
    :ozone,
    :value,
    :label

  def initialize(
    forecasted_at:,
    nitrogen_dioxide:,
    particulate_matter_10:,
    particulate_matter_2_5:,
    ozone:,
    value:,
    label:
  )
    @forecasted_at = forecasted_at
    @nitrogen_dioxide = nitrogen_dioxide
    @particulate_matter_10 = particulate_matter_10
    @particulate_matter_2_5 = particulate_matter_2_5
    @ozone = ozone
    @value = value
    @label = label
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

  # :nocov:
  def inspect
    attr_values = [
      "@forecasted_at=#{forecasted_at}",
      "@nitrogen_dioxide=#{nitrogen_dioxide}>",
      "@particulate_matter_10=#{particulate_matter_10}",
      "@particulate_matter_2_5=#{particulate_matter_2_5}",
      "@ozone=#{ozone}",
      "@value=#{@value}",
      "@label=#{@label}"
    ]

    "#<#{self.class.name} #{attr_values.join(" ")}>"
  end
  # :nocov:
end
