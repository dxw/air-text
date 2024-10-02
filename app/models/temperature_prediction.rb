class TemperaturePrediction
  attr_reader :min, :max

  def initialize(min:, max:)
    @min = min
    @max = max
  end
end
