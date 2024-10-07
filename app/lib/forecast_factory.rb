class ForecastFactory
  def self.build(forecast_representation)
    obtained_at = Time.zone.parse(forecast_representation.fetch("forecastdate"))

    zone = forecast_representation
      .fetch("zones")
      .first

    zone.fetch("forecasts")
      .map do |forecast|
      Forecast.new({
        obtained_at: obtained_at,
        forecast_for: Date.parse(forecast.fetch("forecast_date")),

        zone: ForecastZone.new(
          id: zone.fetch("zone_id"),
          name: zone.fetch("zone_name"),
          type: zone.fetch("zone_type")
        ),

        air_pollution: AirPollutionPrediction.new(
          forecasted_at: Time.zone.parse(forecast.fetch("pollution_version").to_s),
          nitrogen_dioxide: forecast.fetch("NO2"),
          particulate_matter_10: forecast.fetch("PM10"),
          particulate_matter_2_5: forecast.fetch("PM2.5"),
          ozone: forecast.fetch("O3"),
          overall_score: forecast.fetch("total"),
          overall_label: forecast.fetch("total_status")
        ),

        uv: UvPrediction.new(forecast.fetch("uv")),
        pollen: PollenPrediction.new(forecast.fetch("pollen")),
        temperature: TemperaturePrediction.new(
          min: forecast.fetch("temp_min"),
          max: forecast.fetch("temp_max")
        )
      })
    end
  end
end
