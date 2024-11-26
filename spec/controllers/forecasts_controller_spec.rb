RSpec.describe ForecastsController do
  let(:central_london) { double("Central London") }
  let(:barnet) { double("Barnet") }

  before do
    allow(Zone).to receive(:default).and_return(central_london)
    allow(CercForecastService).to receive(:latest_forecasts_for).and_return(forecasts)
  end

  let(:forecasts) do
    FactoryBot.build(:cached_forecast)
  end

  describe "GET :show" do
    context "when NO zone is given" do
      it "obtains forecasts for the default zone (Central London) from the CercForecastService" do
        get :show

        expect(CercForecastService).to have_received(:latest_forecasts_for).with(central_london)
      end
    end

    context "when zone IS given" do
      it "obtains forecasts for the given zone from the CercForecastService" do
        allow(Zone).to receive(:find_by).and_return(barnet)

        get :show, params: {zone: "Barnet"}

        expect(CercForecastService).to have_received(:latest_forecasts_for).with(barnet)
      end
    end

    it "renders the _show_ template" do
      get :show

      expect(response).to render_template("show")
    end

    context "when a _day_ parameter is received" do
      before do
        get :show, params: {day: day}
      end

      context "when a recognised _day_ parameter is received" do
        let(:day) { "tomorrow" }

        it "shows the forecast for the given day" do
          expect(assigns(:day_forecast)).to eq(forecasts.data.second)
        end
      end

      context "when an unrecognised _day_ parameter is received" do
        let(:day) { "invalid" }

        it "shows today's forecast" do
          expect(assigns(:day_forecast)).to eq(forecasts.data.first)
        end
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

      context "when the date is invalid" do
        let(:date) { "invalid" }

        it "shows the forecast for today" do
          expect(assigns(:day_forecast)).to eq(forecasts.data.first)
        end
      end
    end
  end

  context "when a _pollutant_ parameter is received" do
    before do
      get :show, params: {pollutant: pollutant}
    end

    context "when the pollutant is recognised" do
      let(:pollutant) { "PM10" }

      it "set the pollutant to the given value" do
        expect(assigns(:pollutant)).to eq("PM10")
      end
    end

    context "when the pollutant is not recognised" do
      let(:pollutant) { "invalid" }

      it "defaults to showing the Total forecast" do
        expect(assigns(:pollutant)).to eq("Total")
      end
    end
  end
end
