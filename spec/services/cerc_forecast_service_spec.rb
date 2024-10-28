RSpec.describe CercForecastService do
  describe "::latest_forecasts_for(zone)" do
    let(:zone) { FactoryBot.build(:zone, name: "Barnet") }
    let(:latest_forecasts_from_api) { double("latest_forecasts_from_api") }
    let(:latest_forecast_from_cache) { double("latest_forecast_from_cache") }

    before do
      allow(CachedForecast).to receive(:stale?).and_return(true)
      allow(CachedForecast).to receive(:latest_for).and_return(latest_forecast_from_cache)
      allow(CachedForecast).to receive(:store).and_return(true)
      allow(CercApiClient).to receive(:latest_forecasts).and_return(latest_forecasts_from_api)
    end

    context "when the cache is stale" do
      let(:latest_forecasts_from_api) {
        {
          "forecastdate" => "02-10-2024 15:16",
          "timestamp" => 1727882190223.2139,
          "zones" => [
            {
              "forecasts" => [{}, {}, {}],
              "zone_id" => 1,
              "zone_name" => "Barking and Dagenham",
              "zone_type" => 1
            },
            {
              "forecasts" => [{}, {}, {}],
              "zone_id" => 2,
              "zone_name" => "Barnet",
              "zone_type" => 1
            }
          ]
        }
      }

      let(:built_forecasts_for_barking) { double("built_forecasts_for_barking") }
      let(:built_forecasts_for_barnet) { double("built_forecasts_for_barnet") }

      before do
        allow(CachedForecast).to receive(:stale?).and_return(true)

        allow(ForecastFactory).to receive(:build).with(
          cerc_forecasts: latest_forecasts_from_api,
          zone_id: 1
        ).and_return(built_forecasts_for_barking)

        allow(ForecastFactory).to receive(:build).with(
          cerc_forecasts: latest_forecasts_from_api,
          zone_id: 2
        ).and_return(built_forecasts_for_barnet)
      end

      it "asks the CercApiClient for the latest_forecasts (for all zones)" do
        CercForecastService.latest_forecasts_for(zone)

        expect(CercApiClient).to have_received(:latest_forecasts).with(no_args)
      end

      it "builds forecasts for each zone" do
        CercForecastService.latest_forecasts_for(zone)

        expect(ForecastFactory).to have_received(:build).with(
          cerc_forecasts: latest_forecasts_from_api,
          zone_id: 2
        )
        expect(ForecastFactory).to have_received(:build).with(
          cerc_forecasts: latest_forecasts_from_api,
          zone_id: 1
        )
      end

      it "caches a built forecast for each zone" do
        CercForecastService.latest_forecasts_for(zone)

        expect(CachedForecast).to have_received(:store).with(built_forecasts_for_barking)
        expect(CachedForecast).to have_received(:store).with(built_forecasts_for_barnet)
      end

      it "returns the new forecast for the given zone"
    end

    context "when the cache is NOT stale" do
      let(:latest_forecast) { double("latest_forecast") }

      before do
        allow(CachedForecast).to receive(:stale?).and_return(false)
      end

      it "retrieves the cached forecast for the given zone" do
        CercForecastService.latest_forecasts_for(zone)

        expect(CachedForecast).to have_received(:latest_for).with(zone)
      end

      it "returns the cached forecast for the given zone" do
        expect(CercForecastService.latest_forecasts_for(zone)).to eq(latest_forecast_from_cache)
      end
    end
  end
end
