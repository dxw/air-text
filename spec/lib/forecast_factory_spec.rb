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
        expect(forecast.date).to eq(Date.parse("2024-10-02"))

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

    context "when a _zone_ ID is given" do
      context "and the zone ID is present in the forecast_representation" do
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
              "zone_type" => 1},

             {"forecasts" => [
                {"NO2" => 3,
                 "O3" => 3,
                 "PM10" => 3,
                 "PM2.5" => 3,
                 "forecast_date" => "2024-10-02",
                 "non_pollution_version" => nil,
                 "pollen" => -999,
                 "pollution_version" => 202410021550,
                 "rain_am" => 0.33,
                 "rain_pm" => 0.3,
                 "temp_max" => 33.3,
                 "temp_min" => 13.3,
                 "total" => 3,
                 "total_status" => "LOW",
                 "uv" => 3,
                 "wind_am" => 33.3,
                 "wind_pm" => 3.33}
              ],
              "zone_id" => 2,
              "zone_name" => "Barnet",
              "zone_type" => 1}
           ]}
        end

        it "builds forecasts for that zone" do
          forecast = ForecastFactory.build(forecast_representation_from_api, 2).first

          aggregate_failures do
            expect(forecast.obtained_at).to eq(Time.zone.parse("02-10-2024 15:38"))
            expect(forecast.date).to eq(Date.parse("2024-10-02"))

            expect(forecast.zone.name).to eq("Barnet")
            expect(forecast.zone.id).to eq(2)
            expect(forecast.zone.type).to eq("London Borough")

            expect(forecast.air_pollution.forecasted_at).to eq(Time.zone.parse("202410021550"))
            expect(forecast.air_pollution.nitrogen_dioxide).to eq(3)
            expect(forecast.air_pollution.particulate_matter_10).to eq(3)
            expect(forecast.air_pollution.particulate_matter_2_5).to eq(3)
            expect(forecast.air_pollution.ozone).to eq(3)
            expect(forecast.air_pollution.value).to eq(3)
            expect(forecast.air_pollution.daqi_label).to eq("Low")
            expect(forecast.air_pollution.daqi_level).to eq(:low)

            expect(forecast.uv.value).to eq(3)
            expect(forecast.uv.daqi_label).to eq("Low")
            expect(forecast.uv.guidance).to eq("No action required. You can safely stay outside.")

            expect(forecast.pollen.value).to eq(-999)

            expect(forecast.temperature.min).to eq(13.3)
            expect(forecast.temperature.max).to eq(33.3)
          end
        end
      end

      context "and the zone ID is NOT present in the forecast_representation" do
        it "raises an error" do
          expect {
            ForecastFactory.build(forecast_representation_from_api, 12345678)
          }.to raise_error("Forecast for zone ID '12345678' not found")
        end
      end
    end
  end
end
