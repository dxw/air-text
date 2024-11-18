# frozen_string_literal: true

class PredictionComponent < ViewComponent::Base
  def initialize(prediction:)
    @prediction = prediction
  end

  def name_for_class
    @prediction.name.parameterize
  end

  def name_for_label
    @prediction.name
  end

  def daqi_level_for_class
    @prediction.daqi_level.to_s.parameterize
  end

  def daqi_level_for_label
    @prediction.daqi_label
  end

  def guidance_panel_colour
    "bg-#{@prediction.daqi_label.parameterize}-alert-guidance-panel"
  end

  def guidance
    I18n.t(
      "prediction.guidance.#{@prediction.name.parameterize(separator: "_")}.#{@prediction.daqi_level}"
    )
  end

  def guidance_visible?
    @prediction.daqi_level != :low
  end
end
