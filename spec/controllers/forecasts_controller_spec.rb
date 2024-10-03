RSpec.describe ForecastsController do
  around do |example|
    env_vars = {
      CERC_API_HOST_URL: "https://cerc.example.com",
      CERC_API_KEY: "SECRET-API-KEY"
    }
    ClimateControl.modify(env_vars) { example.run }
  end

  describe "GET :show" do
    let(:json) do
      <<~JSON
        {
          "forecastdate": "01-10-2024 14:40",
          "timestamp": 1727793654317.342,
          "zones": [
            {
              "forecasts": [
                {
                  "NO2": 1,
                  "O3": 2,
                  "PM10": 1,
                  "PM2.5": 1,
                  "forecast_date": "2024-10-01",
                  "non_pollution_version": null,
                  "pollen": -999,
                  "pollution_version": 202410011407,
                  "rain_am": 1.31,
                  "rain_pm": 3.01,
                  "temp_max": 14.0,
                  "temp_min": 10.4,
                  "total": 2,
                  "total_status": "LOW",
                  "uv": 1,
                  "wind_am": 5.3,
                  "wind_pm": 6.0
                }
              ],
              "zone_id": 14,
              "zone_name": "Haringey",
              "zone_type": 1
            }
          ]
        }
      JSON
    end

    let(:forecasts) do
      ForecastFactory.build(JSON.parse(json))
    end

    it "obtains forecasts for the default zone (Southwark) from the CercApiClient" do
      allow(CercApiClient).to receive(:forecasts_for).and_return(forecasts)

      get :show

      expect(CercApiClient).to have_received(:forecasts_for).with("Southwark")
      expect(response).to render_template("show")
    end

    it "renders the _show_ template" do
      allow(CercApiClient).to receive(:forecasts_for).and_return(forecasts)

      get :show

      expect(response).to render_template("show")
    end

    it "asks the forecasts for any alerts and assigns to instance variable" do
      air_quality_alert = double("air quality alert")
      forecast_1 = instance_double(Forecast, alerts: [])
      forecast_2 = instance_double(Forecast, alerts: [air_quality_alert])

      allow(CercApiClient).to receive(:forecasts_for).and_return([
        forecast_1,
        forecast_2
      ])

      get :show

      expect(forecast_1).to have_received(:alerts)
      expect(forecast_2).to have_received(:alerts)

      expect(assigns(:air_quality_alerts)).to eq([air_quality_alert])
    end
  end
end
