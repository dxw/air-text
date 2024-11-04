RSpec.describe ForecastsController do
  around do |example|
    env_vars = {
      MAPTILER_API_KEY: "TOPSECRET"
    }
    ClimateControl.modify(env_vars) { example.run }
  end

  let(:southwark) { double("Southwark") }
  let(:barnet) { double("Barnet") }

  before do
    allow(Zone).to receive(:find_by).and_return(barnet)
    allow(Zone).to receive(:default).and_return(southwark)
  end

  let(:forecasts) do
    FactoryBot.build(:cached_forecast)
  end

  describe "GET :show" do
    context "when NO zone is given" do
      it "obtains forecasts for the default zone (Southwark) from the CercForecastService" do
        allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

        get :show

        expect(CercForecastService).to have_received(:latest_forecasts_for).with(southwark)
      end
    end

    context "when zone IS given" do
      it "obtains forecasts for the given zone from the CercForecastService" do
        allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

        get :show, params: {zone: double}

        expect(CercForecastService).to have_received(:latest_forecasts_for).with(barnet)
      end
    end

    it "renders the _show_ template" do
      allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

      get :show

      expect(response).to render_template("show")
    end
  end

  describe "GET :update" do
    context "when a recognised _day_ parameter is received" do
      it "renders the turbo update template" do
        allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

        get :update, params: {day: :today}, format: :turbo_stream

        expect(CercForecastService).to have_received(:latest_forecasts_for).with(southwark)
        expect(response).to render_template("forecasts/update")
      end
    end

    context "when an unrecognised _day_ parameter is received" do
      it "raises a helpful error" do
        allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

        expect {
          get :update, params: {day: :yesterday}
        }.to raise_error(ArgumentError, "Invalid day: yesterday")
      end
    end
  end
end
