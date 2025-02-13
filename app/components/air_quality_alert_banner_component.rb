class AirQualityAlertBannerComponent < ViewComponent::Base
  def initialize
    @alert_label = highest_alert[:label]
    @alert_level = highest_alert[:value]
  end

  def alert?
    @alert_label != "LOW"
  end

  def message
    if alert?
      "#{@alert_label.humanize} air pollution alert"
    else
      "No air pollution alerts"
    end
  end

  def daqi_classes
    "daqi-level-#{@alert_level} daqi-label-#{@alert_label.parameterize}"
  end

  private

  def highest_alert
    @highest_alert ||= pollution_values.flatten.max_by { |h| h[:value] }
  end

  def pollution_values
    CercForecastService.latest_forecasts.map do |cached_forecast|
      cached_forecast.data.map do |forecast|
        {value: forecast.air_pollution[:total], label: forecast.air_pollution[:label]}
      end
    end
  end
end
