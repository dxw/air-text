class AirPollutionPrediction
  attr_reader :forecasted_at,
    :nitrogen_dioxide,
    :particulate_matter_10,
    :particulate_matter_2_5,
    :ozone,
    :overall_score

  def initialize(
    forecasted_at:,
    nitrogen_dioxide:,
    particulate_matter_10:,
    particulate_matter_2_5:,
    ozone:,
    overall_score:,
    overall_label:
  )
    @forecasted_at = forecasted_at
    @nitrogen_dioxide = nitrogen_dioxide
    @particulate_matter_10 = particulate_matter_10
    @particulate_matter_2_5 = particulate_matter_2_5
    @ozone = ozone
    @overall_score = overall_score
    @overall_label = overall_label
  end

  def overall_label
    ActiveSupport::Inflector.upcase_first(@overall_label.downcase)
  end

  def inspect
    attr_values = [
      "@forecasted_at=#{forecasted_at}",
      "@nitrogen_dioxide=#{nitrogen_dioxide}>",
      "@particulate_matter_10=#{particulate_matter_10}",
      "@particulate_matter_2_5=#{particulate_matter_2_5}",
      "@ozone=#{ozone}",
      "@overall_score=#{overall_score}",
      "@overall_label=#{@overall_label}"
    ]

    "#<#{self.class.name} #{attr_values.join(" ")}>"
  end
end
