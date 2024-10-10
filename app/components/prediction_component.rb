# frozen_string_literal: true

class PredictionComponent < ViewComponent::Base
  def initialize(prediction:)
    @prediction = prediction
  end

  def name_for_class
    @prediction.name.parameterize
  end

  def daqi_level_for_class
    @prediction.daqi_level.to_s.parameterize
  end

  def daqi_indicator_colour
    case @prediction.daqi_level
    when :low
      "text-green-600"
    when :moderate
      "text-amber-300"
    when :high
      "text-red-500"
    when :very_high
      "text-stone-700"
    else
      raise "DAQI level '#{@prediction.daqi_level}' not known"
    end
  end
end
