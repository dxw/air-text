class TemperaturePrediction
  attr_reader :min_c, :max_c, :min_f, :max_f

  def initialize(min:, max:)
    @min_c = min
    @max_c = max
    @min_f = farenheit(min)
    @max_f = farenheit(max)
  end

  def name
    "Temperature"
  end

  def farenheit(celsius)
    (celsius * 9 / 5) + 32
  end

  # :nocov:
  def inspect
    "#<#{self.class.name} @min=#{min_c} @max=#{max_c}>"
  end
  # :nocov:
end
