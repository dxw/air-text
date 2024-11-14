RSpec.describe CercForecastService do
  describe "::latest_forecasts_for(zone)" do
    let(:zone) { FactoryBot.create(:zone, cerc_id: 29) }

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
        cached_temperature = CercForecastService.latest_forecasts_for(zone).data.first.temperature.max
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
end
