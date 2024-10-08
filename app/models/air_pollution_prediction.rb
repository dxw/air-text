class AirPollutionPrediction
  include DaqiProperties

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
