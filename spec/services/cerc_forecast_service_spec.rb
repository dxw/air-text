RSpec.describe CercForecastService do
  describe "::latest_forecasts_for(zone)" do
    let(:zone) { FactoryBot.create(:zone, cerc_id: 55) }

    context "when the cache is stale" do
      let(:latest_forecasts_from_api) { Fixtures::API.all_forecasts }

      before do
        allow(CachedForecast).to receive(:stale?).and_return(true)
        allow(CercApiClient).to receive(:latest_forecasts).and_return(latest_forecasts_from_api)
      end

      it "asks the CercApiClient for the latest_forecasts (for all zones)" do
        CercForecastService.latest_forecasts_for(zone)

        expect(CercApiClient).to have_received(:latest_forecasts).with(no_args)
      end

      it "caches a built forecast for each zone" do
        api_temperature = latest_forecasts_from_api["zones"].first["forecasts"].first["temp_max"]
        cached_temperature = CercForecastService.latest_forecasts_for(zone).data.first.temperature.max_c
        expect(cached_temperature).to eq(api_temperature)
      end
    end

    context "when the cache is NOT stale" do
      let(:latest_forecast_from_cache) { double("CachedForecast") }
      before do
        allow(CachedForecast).to receive(:stale?).and_return(false)
        allow(CercApiClient).to receive(:latest_forecasts)
        allow(CachedForecast).to receive(:latest_for).and_return(latest_forecast_from_cache)
      end

      it "does not ask the CercApiClient for the latest_forecasts" do
        CercForecastService.latest_forecasts_for(zone)

        expect(CercApiClient).not_to have_received(:latest_forecasts)
      end

      it "returns the cached forecast for the given zone" do
        expect(CercForecastService.latest_forecasts_for(zone)).to eq(latest_forecast_from_cache)
      end
    end
  end

  describe "::zone_forecasts" do
    let(:forecast_representation_from_api) do
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
    end

    it "returns a list of Forecasts from the response returned by CERC's API" do
      forecasts = CercForecastService.send(:zone_forecasts, forecast_representation_from_api)

      expect(forecasts.size).to eq(1)
    end

    it "builds each Forecast as expected" do
      forecast = CercForecastService.send(:zone_forecasts, forecast_representation_from_api).first

      aggregate_failures do
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

        expect(forecast.temperature.min_c).to eq(10.0)
        expect(forecast.temperature.min_f).to eq(50.0)
        expect(forecast.temperature.max_c).to eq(16.6)
        expect(forecast.temperature.max_f).to eq(61.88)
      end
    end
  end
end
