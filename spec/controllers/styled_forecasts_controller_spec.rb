RSpec.describe StyledForecastsController do
  around do |example|
    env_vars = {
      CERC_API_HOST_URL: "https://cerc.example.com",
      CERC_API_KEY: "SECRET-API-KEY"
    }
    ClimateControl.modify(env_vars) { example.run }
  end

  let(:forecast_from_api) do
    {
      "forecastdate" => "01-10-2024 14:40",
      "timestamp" => 1727793654317.342,
      "zones" => [
        {
          "forecasts" => [
            {
              "NO2" => 1,
              "O3" => 2,
              "PM10" => 1,
              "PM2.5" => 1,
              "forecast_date" => "2024-10-01",
              "non_pollution_version" => nil,
              "pollen" => -999,
              "pollution_version" => 202410011407,
              "rain_am" => 1.31,
              "rain_pm" => 3.01,
              "temp_max" => 14.0,
              "temp_min" => 10.4,
              "total" => 2,
              "total_status" => "LOW",
              "uv" => 1,
              "wind_am" => 5.3,
              "wind_pm" => 6.0
            },
            {
              "NO2" => 1,
              "O3" => 2,
              "PM10" => 1,
              "PM2.5" => 1,
              "forecast_date" => "2024-10-02",
              "non_pollution_version" => nil,
              "pollen" => -999,
              "pollution_version" => 202410011407,
              "rain_am" => 1.31,
              "rain_pm" => 3.01,
              "temp_max" => 14.0,
              "temp_min" => 10.4,
              "total" => 2,
              "total_status" => "LOW",
              "uv" => 1,
              "wind_am" => 5.3,
              "wind_pm" => 6.0
            },
            {
              "NO2" => 1,
              "O3" => 2,
              "PM10" => 1,
              "PM2.5" => 1,
              "forecast_date" => "2024-10-03",
              "non_pollution_version" => nil,
              "pollen" => -999,
              "pollution_version" => 202410011407,
              "rain_am" => 1.31,
              "rain_pm" => 3.01,
              "temp_max" => 14.0,
              "temp_min" => 10.4,
              "total" => 2,
              "total_status" => "LOW",
              "uv" => 1,
              "wind_am" => 5.3,
              "wind_pm" => 6.0
            }
          ],
          "zone_id" => 14,
          "zone_name" => "Haringey",
          "zone_type" => 1
        }
      ]
    }
  end

  let(:forecasts) do
    ForecastFactory.build(forecast_from_api)
  end

  describe "GET :show" do
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
  end

  describe "GET :update" do
    let(:forecasts) do
      ForecastFactory.build(forecast_from_api)
    end

    let(:tag_builder) do
      instance_double(Turbo::Streams::TagBuilder, replace: true)
    end

    before do
      allow(Turbo::Streams::TagBuilder).to receive(:new).and_return(tag_builder)
    end

    it "returns a predictions partial template within a turbo stream replace element" do
      allow(CercApiClient).to receive(:forecasts_for).and_return(forecasts)

      get :update, params: {day: :tomorrow}

      expect(CercApiClient).to have_received(:forecasts_for).with("Southwark")
      expect(tag_builder).to have_received(:replace).with(
        "day_predictions",
        partial: "predictions",
        locals: {forecast: forecasts.second}
      )
    end

    it "raises a helpful error if an unexpected _day_ is received" do
      allow(CercApiClient).to receive(:forecasts_for).and_return(forecasts)

      expect {
        get :update, params: {day: :yesterday}
      }.to raise_error(ArgumentError, "Invalid day: yesterday")
    end
  end
end
