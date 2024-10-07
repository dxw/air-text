class UvPrediction
  attr_reader :level, :label, :guidance

  def initialize(level)
    @level = level
    case level
    when 1..3
      @label = "Low"
      @guidance = "No action required. You can safely stay outside."
    when 4..6
      @label = "Moderate"
      @guidance = "Protection required. Seek shade during midday hours, cover up and wear suncream."
    when 7..9
      @label = "High"
      @guidance = "some high UV guidance"
    else
      @label = "Very high"
      @guidance = "some very high UV guidance"
    end
  end

  # :nocov:
  def inspect
    "#<#{self.class.name} @level=#{level} @label=#{label} @guidance=#{guidance}>"
  end
  # :nocov:
end
