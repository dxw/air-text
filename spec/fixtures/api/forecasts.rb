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
          "forecast_date" => forecast_date_for(day),
          "non_pollution_version" => nil,
          "pollen" => daqi_value_for_level(pollen),
          "pollution_version" => 202410011407,
          "rain_am" => 1.31,
          "rain_pm" => 3.01,
          "temp_max" => max_temp_for(temperature),
          "temp_min" => min_temp_for(temperature),
          "total" => daqi_value || daqi_value_for_level(air_pollution_status),
          "total_status" => total_status_for(air_pollution_status).to_s,
          "uv" => daqi_value_for_level(uv),
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
          Date.today + 1.day
        when :day_after_tomorrow
          Date.today + 2.days
        else
          raise "day: #{day} not expected"
        end

        date.iso8601
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

      def daqi_value_for_level(daqi_level)
        case daqi_level
        when :low
          [1, 2, 3].sample
        when :moderate
          [4, 5, 6].sample
        when :high
          [7, 8, 9].sample
        when :very_high
          10
        else
          raise "DAQI level of #{level} not known"
        end
      end
    end
  end
end
