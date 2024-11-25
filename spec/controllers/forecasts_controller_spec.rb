RSpec.describe ForecastsController do
  let(:southwark) { double("Southwark") }
  let(:barnet) { double("Barnet") }

  before do
    allow(Zone).to receive(:find_by).and_return(barnet)
    allow(Zone).to receive(:default).and_return(southwark)
    allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)
  end

  let(:forecasts) do
    FactoryBot.build(:cached_forecast)
  end

  describe "GET :show" do
    context "when NO zone is given" do
      it "obtains forecasts for the default zone (Southwark) from the CercForecastService" do
        get :show

        expect(CercForecastService).to have_received(:latest_forecasts_for).with(southwark)
      end
    end

    context "when zone IS given" do
      it "obtains forecasts for the given zone from the CercForecastService" do
        get :show, params: {zone: double}

        expect(CercForecastService).to have_received(:latest_forecasts_for).with(barnet)
      end
    end

    it "renders the _show_ template" do
      get :show

      expect(response).to render_template("show")
    end

    context "when a recognised _day_ parameter is received" do
      it "renders the _show_ template" do
        get :show, params: {day: :today}

        expect(CercForecastService).to have_received(:latest_forecasts_for).with(southwark)
        expect(response).to render_template("show")
      end
    end

    context "when an unrecognised _day_ parameter is received" do
      it "raises a helpful error" do
        expect {
          get :show, params: {day: :yesterday}
        }.to raise_error(ArgumentError, "Invalid day: yesterday")
      end
    end

    context "when a _date_ parameter is received" do
      before do
        get :show, params: {date: date.to_s}
      end

      context "when the date is in the past" do
        let(:date) { 5.day.ago.to_date }

        it "shows the forecast for today" do
          expect(assigns(:day_forecast)).to eq(forecasts.data.first)
        end
      end

      context "when the date is today" do
        let(:date) { Date.today }

        it "shows the forecast for today" do
          expect(assigns(:day_forecast)).to eq(forecasts.data.first)
        end
      end

      context "when the date is tomorrow" do
        let(:date) { Date.tomorrow }

        it "shows the forecast for tomorrow" do
          expect(assigns(:day_forecast)).to eq(forecasts.data.second)
        end
      end

      context "when the date is the day after tomorrow" do
        let(:date) { 2.days.from_now.to_date }

        it "shows the forecast for the day after tomorrow" do
          expect(assigns(:day_forecast)).to eq(forecasts.data.third)
        end
      end

      context "when the date is in the future" do
        let(:date) { 5.days.from_now.to_date }

        it "shows the forecast for the day after tomorrow" do
          expect(assigns(:day_forecast)).to eq(forecasts.data.third)
        end
      end
    end
  end
end
