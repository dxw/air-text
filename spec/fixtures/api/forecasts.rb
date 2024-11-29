module Fixtures
  module API
    class << self
      def all_forecasts(forecasts = [])
        {
          "forecastdate" => "07-11-2024 19:54",
          "timestamp" => 1731009262649.986,
          "zones" => [
            zone_object(forecasts: forecasts)
          ]
        }
      end

      def zone_object(zone_id: 55, forecasts: [])
        {
          "forecasts" => forecasts.presence || [zone_forecast],
          "zone_id" => zone_id,
          "zone_name" => "Central London",
          "zone_type" => 1
        }
      end

      def zone_forecast(day: :today, air_pollution_status: :low, pollen: :moderate, temperature: :normal, uv: :moderate, daqi_value: nil)
        {
          "NO2" => 1,
          "O3" => 2,
          "PM10" => 1,
          "PM2.5" => 1,
          "forecast_date" => forecast_date_for(day).to_s,
          "non_pollution_version" => nil,
          "pollen" => value_for_level(:pollen, pollen),
          "pollution_version" => 202410011407,
          "rain_am" => 1.31,
          "rain_pm" => 3.01,
          "temp_max" => max_temp_for(temperature),
          "temp_min" => min_temp_for(temperature),
          "total" => daqi_value || value_for_level(:daqi, air_pollution_status),
          "total_status" => air_pollution_status.to_s.humanize.upcase,
          "uv" => value_for_level(:uv, uv),
          "wind_am" => 5.3,
          "wind_pm" => 6.0
        }
      end

      def min_temp_for(temperature)
        case temperature
        when :cold
          -5.2
        when :normal
          8.9
        when :hot
          26.9
        else
          raise "temperature: #{temperature} not expected"
        end
      end

      def max_temp_for(temperature)
        case temperature
        when :cold
          3.6
        when :normal
          16.4
        when :hot
          31.1
        else
          raise "temperature: #{temperature} not expected"
        end
      end

      def forecast_date_for(day)
        date = case day
        when :today
          Date.today
        when :tomorrow
          Date.tomorrow
        when :day_after_tomorrow
          Date.tomorrow + 1.day
        else
          raise "day: #{day} not expected"
        end

        date.iso8601
      end

      def value_for_level(type, value)
        {
          daqi: {
            low: [1, 2, 3].sample,
            moderate: [4, 5, 6].sample,
            high: [7, 8, 9].sample,
            very_high: 10
          },
          pollen: {
            low: [1, 2, 3].sample,
            moderate: [4, 5, 6].sample,
            high: [7, 8, 9].sample,
            very_high: 10
          },
          uv: {
            low: [1, 2].sample,
            moderate: [3, 4, 5].sample,
            high: [6, 7].sample,
            very_high: [8, 9, 10].sample
          }
        }[type][value]
      end
    end
  end
end
