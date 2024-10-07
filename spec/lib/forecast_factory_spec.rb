RSpec.describe ForecastFactory do
  describe "::build(forecast_representation)" do
    let(:forecast_representation_from_api) do
      {"forecastdate" => "02-10-2024 15:38",
       "timestamp" => 1727883524517.199,
       "zones" => [
         {"forecasts" => [
            {"NO2" => 1,
             "O3" => 2,
             "PM10" => 1,
             "PM2.5" => 1,
             "forecast_date" => "2024-10-02",
             "non_pollution_version" => nil,
             "pollen" => -999,
             "pollution_version" => 202410021550,
             "rain_am" => 0.81,
             "rain_pm" => 0.66,
             "temp_max" => 16.6,
             "temp_min" => 10.0,
             "total" => 10,
             "total_status" => "VERY HIGH",
             "uv" => 2,
             "wind_am" => 4.9,
             "wind_pm" => 5.3}
          ],
          "zone_id" => 29,
          "zone_name" => "Southwark",
          "zone_type" => 1}
       ]}
    end

    it "returns a list of Forecasts from the response returned by CERC's API" do
      forecasts = ForecastFactory.build(forecast_representation_from_api)

      expect(forecasts.size).to eq(1)
    end

    it "builds each Forecast as expected" do
      forecast = ForecastFactory.build(forecast_representation_from_api).first

      aggregate_failures do
        expect(forecast.obtained_at).to eq(Time.zone.parse("02-10-2024 15:38"))
        expect(forecast.forecast_for).to eq(Date.parse("2024-10-02"))

        expect(forecast.zone.name).to eq("Southwark")
        expect(forecast.zone.id).to eq(29)
        expect(forecast.zone.type).to eq("London Borough")

        expect(forecast.air_pollution.forecasted_at).to eq(Time.zone.parse("202410021550"))
        expect(forecast.air_pollution.nitrogen_dioxide).to eq(1)
        expect(forecast.air_pollution.particulate_matter_10).to eq(1)
        expect(forecast.air_pollution.particulate_matter_2_5).to eq(1)
        expect(forecast.air_pollution.ozone).to eq(2)
        expect(forecast.air_pollution.value).to eq(10)
        expect(forecast.air_pollution.daqi_label).to eq("Very high")
        expect(forecast.air_pollution.daqi_level).to eq(:very_high)

        expect(forecast.uv.value).to eq(2)
        expect(forecast.uv.daqi_label).to eq("Low")
        expect(forecast.uv.guidance).to eq("No action required. You can safely stay outside.")

        expect(forecast.pollen.value).to eq(-999)

        expect(forecast.temperature.min).to eq(10.0)
        expect(forecast.temperature.max).to eq(16.6)
      end
    end
  end
end
