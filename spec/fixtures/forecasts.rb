module Fixtures
  class << self
    def build_forecast(day:, air_pollution_status:)
      <<~JSON
        {
          "NO2": 1,
          "O3": 2,
          "PM10": 1,
          "PM2.5": 1,
          "forecast_date": "#{forecast_date_for(day)}",
          "non_pollution_version": null,
          "pollen": -999,
          "pollution_version": 202410011407,
          "rain_am": 1.31,
          "rain_pm": 3.01,
          "temp_max": 14.0,
          "temp_min": 10.4,
          "total": "#{total_for(air_pollution_status)}",
          "total_status": "#{total_status_for(air_pollution_status)}",
          "uv": 1,
          "wind_am": 5.3,
          "wind_pm": 6.0
        }
      JSON
    end

    def forecast_date_for(day)
      date = case day
      when :today
        Date.today
      when :tomorrow
        Date.today + 1.day
      when :day_after_tomorrow
        Date.today + 2.days
      else
        raise "day: #{day} not expected"
      end

      date.iso8601
    end

    def total_for(air_pollution_status)
      case air_pollution_status
      when :low
        [1, 2, 3].sample
      when :moderate
        [4, 5, 6].sample
      when :high
        [7, 8, 9].sample
      when :very_high
        10
      end
    end

    def total_status_for(air_pollution_status)
      case air_pollution_status
      when :low
        "LOW"
      when :moderate
        "MODERATE"
      when :high
        "HIGH"
      when :very_high
        "VERY HIGH"
      end
    end

    def forecast_wrapper_around(forecasts)
      <<~JSON
        {
          "forecastdate": "01-10-2024 14:40",
          "timestamp": 1727793654317.342,
          "zones": [
            {
              "forecasts": [
                #{forecasts.join(", ")}
              ],
              "zone_id": 14,
              "zone_name": "Haringey",
              "zone_type": 1
            }
          ]
        }
      JSON
    end
  end
end