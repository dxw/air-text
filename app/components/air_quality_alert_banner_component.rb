class AirQualityAlertBannerComponent < ViewComponent::Base
  def initialize
    @level_label = highest_alert
  end

  def alert?
    @level_label != "LOW"
  end

  def message
    if alert?
      "#{highest_alert.humanize} air pollution alert"
    else
      "No air pollution alerts"
    end
  end

  def icon_stroke_colour_class
    ["HIGH", "VERY HIGH"].include?(@level_label) ? "stroke-white" : "stroke-black"
  end

  private

  def highest_alert
    [
      "VERY HIGH",
      "HIGH",
      "MODERATE",
      "LOW"
    ].each do |label|
      return label if pollution_labels.flatten.include?(label)
    end
  end

  def pollution_labels
    CercForecastService.latest_forecasts.map do |cached_forecast|
      cached_forecast.data.map do |forecast|
        forecast.air_pollution[:label]
      end
    end
  end
end
