RSpec.describe CercApiClient do
  around do |example|
    env_vars = {
      CERC_API_HOST_URL: "https://example.com",
      CERC_API_KEY: "ABC123"
    }
    ClimateControl.modify(env_vars) { example.run }
  end

  describe "#latest_forecasts" do
    it "makes a request to the API with the expected parameters" do
      allow(HTTParty).to receive(:get)

      CercApiClient.latest_forecasts("North London")
      expect(HTTParty).to have_received(:get).with("https://example.com/getforecast/all", {
        query: {
          "zone" => "North London",
          "key" => "ABC123",
          "numdays" => 3,
          "from" => Date.today
        }
      })
    end

    describe "for all zones" do
      let(:forecasts_for_all_zones) do
        {
          "forecastdate" => "02-10-2024 15:16",
          "timestamp" => 1727882190223.2139,
          "zones" => [
            {
              "forecasts" => [{}, {}, {}],
              "zone_id" => 1,
              "zone_name" => "Barking and Dagenham",
              "zone_type" => 1
            },
            {
              "forecasts" => [{}, {}, {}],
              "zone_id" => 2,
              "zone_name" => "Barnet",
              "zone_type" => 1
            }
          ]
        }
      end

      before { allow(HTTParty).to receive(:get).and_return(forecasts_for_all_zones) }

      it "asks the CERC API for 3 days worth of forecasts for each zone" do
        CercApiClient.latest_forecasts

        expect(HTTParty).to have_received(:get).with("https://example.com/getforecast/all", {
          query: {
            "key" => "ABC123",
            "numdays" => 3,
            "from" => Date.today
          }
        })
      end

      it "returns 3 daily forecasts for each zone" do
        expect(CercApiClient.latest_forecasts).to eq(forecasts_for_all_zones)
      end
    end
  end
end
