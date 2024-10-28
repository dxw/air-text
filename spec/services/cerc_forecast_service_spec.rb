RSpec.describe CercForecastService do
  describe "::latest_forecasts_for(zone)" do
    let(:zone) { FactoryBot.build(:zone, name: "Barnet") }
    let(:latest_forecasts_from_api) { double("latest_forecasts_from_api") }
    let(:latest_forecast_from_cache) { double("latest_forecast_from_cache") }

    before do
      allow(CachedForecast).to receive(:stale?).and_return(true)
      allow(CachedForecast).to receive(:latest_for).and_return(latest_forecast_from_cache)
      allow(CercApiClient).to receive(:latest_forecasts).and_return(latest_forecasts_from_api)
    end

    context "when the cache is stale" do
      before do
        allow(CachedForecast).to receive(:stale?).and_return(true)
      end

      it "asks the CercApiClient for the latest_forecasts (for all zones)" do
        CercForecastService.latest_forecasts_for(zone)

        expect(CercApiClient).to have_received(:latest_forecasts).with(no_args)
      end

      it "caches a forecast (3 day-forecasts) for each zone"
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
