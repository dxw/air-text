class UvPrediction
  include DaqiProperties

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def name
    "Ultraviolet rays (UV)"
  end

  def guidance
    I18n.t("prediction.guidance.ultraviolet_rays_uv.#{daqi_level}")
  end

  # :nocov:
  def inspect
    "#<#{self.class.name} @value=#{value}>"
  end
end
