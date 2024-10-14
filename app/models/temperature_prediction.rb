class TemperaturePrediction
  attr_reader :min, :max

  def initialize(min:, max:)
    @min = min
    @max = max
  end

  def name
    "Temperature"
  end

  # :nocov:
  def inspect
    "#<#{self.class.name} @min=#{min} @max=#{max}>"
  end
  # :nocov:
end
