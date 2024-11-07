class PollenPrediction
  include DaqiProperties

  attr_reader :value

  def initialize(value:)
    @value = value
  end

  def name
    "Pollen"
  end

  def guidance
    I18n.t("prediction.guidance.pollen.#{daqi_level}")
  end

  def valid?
    value != -999
  end

  # :nocov:
  def inspect
    "#<#{self.class.name} @value=#{value}>"
  end
  # :nocov:
end
