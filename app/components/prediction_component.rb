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
end
