RSpec.describe ForecastsController do
  let(:southwark) { double("Southwark") }
  let(:barnet) { double("Barnet") }

  before do
    allow(Zone).to receive(:find_by).and_return(barnet)
    allow(Zone).to receive(:default).and_return(southwark)
  end

  describe "GET :show" do
    let(:forecasts) do
      FactoryBot.build(:cached_forecast)
    end

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

    it "asks the forecasts for any alerts and assigns to instance variable" do
      air_quality_alert = double("air quality alert")
      forecast_1 = FactoryBot.build(:forecast)
      forecast_2 = FactoryBot.build(:forecast)

      allow(forecast_1).to receive(:alerts).and_return([])
      allow(forecast_2).to receive(:alerts).and_return([air_quality_alert])

      cached_forecast = FactoryBot.build(:cached_forecast).tap do |cf|
        allow(cf).to receive(:data).and_return([forecast_1, forecast_2])
      end

      allow(CercForecastService).to receive(:latest_forecasts_for)
        .and_return(cached_forecast)

      get :show

      expect(assigns(:air_quality_alerts)).to eq([air_quality_alert])
    end
  end
end
