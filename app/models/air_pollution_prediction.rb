class AirPollutionPrediction
  attr_reader :forecasted_at,
    :nitrogen_dioxide,
    :particulate_matter_10,
    :particulate_matter_2_5,
    :ozone,
    :overall_score,
    :overall_label

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
end
