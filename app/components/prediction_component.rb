# frozen_string_literal: true

class PredictionComponent < ViewComponent::Base
  def initialize(prediction:)
    @prediction = prediction
  end
end
