RSpec.describe ForecastsController do
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

    context "when an invalid zone is given" do
      it "obtains forecasts for the default zone (Southwark) from the CercForecastService" do
        allow(Zone).to receive(:find_by).and_return(nil)
        allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

        get :show, params: {zone: "Timbuktu"}

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

    context "when NO day is given" do
      it "sets selected_day to be today" do
        allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

        get :show

        expect(assigns(:selected_day)).to eq("today")
      end
    end

    context "when an invalid day is given" do
      it "sets selected_day to be today" do
        allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

        get :show, params: {day: "yesterday"}

        expect(assigns(:selected_day)).to eq("today")
      end
    end

    context "when a valid day is given" do
      it "sets selected_day to be that day" do
        allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

        get :show, params: {day: "day_after_tomorrow"}

        expect(assigns(:selected_day)).to eq("day_after_tomorrow")
      end
    end
  end

  describe "GET :update" do
    context "when a recognised _day_ parameter is received" do
      it "renders the turbo update template" do
        allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

        get :update, params: {day: "today"}, format: :turbo_stream

        expect(CercForecastService).to have_received(:latest_forecasts_for).with(southwark)
        expect(response).to render_template("forecasts/update")
      end
    end
  end
end
