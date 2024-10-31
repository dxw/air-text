RSpec.describe StyledForecastsController do
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
    let(:tag_builder) do
      instance_double(Turbo::Streams::TagBuilder, replace: true)
    end

    before do
      allow(Turbo::Streams::TagBuilder).to receive(:new).and_return(tag_builder)
    end

    context "when a recognised _day_ parameter is received" do
      describe "when the day is _today_" do
        it "passes the first forecast to the view" do
          allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

          get :update, params: {day: :today}

          expect(CercForecastService).to have_received(:latest_forecasts_for).with(southwark)
          expect(tag_builder).to have_received(:replace).with(
            "day_predictions",
            partial: "predictions",
            locals: {forecast: forecasts.data.first}
          )
        end
      end

      describe "when the day is _tomorrow_" do
        it "passes the second forecast to the view" do
          allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

          get :update, params: {day: :tomorrow}

          expect(CercForecastService).to have_received(:latest_forecasts_for).with(southwark)
          expect(tag_builder).to have_received(:replace).with(
            "day_predictions",
            partial: "predictions",
            locals: {forecast: forecasts.data.second}
          )
        end
      end

      describe "when the day is _day_after_tomorrow_" do
        it "passes the third forecast to the view" do
          allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)

          get :update, params: {day: :day_after_tomorrow}

          expect(CercForecastService).to have_received(:latest_forecasts_for).with(southwark)
          expect(tag_builder).to have_received(:replace).with(
            "day_predictions",
            partial: "predictions",
            locals: {forecast: forecasts.data.third}
          )
        end
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
