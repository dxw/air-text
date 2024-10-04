RSpec.describe CercApiClient do
  before do
    allow(ENV).to receive(:fetch).with("CERC_API_HOST_URL").and_return("https://example.com")
    allow(ENV).to receive(:fetch).with("CERC_API_KEY").and_return("ABC123")
  end

  describe "#fetch_data" do
    it "makes a request to the API with the expected parameters" do
      allow(HTTParty).to receive(:get)

      CercApiClient.fetch_data("North London")
      expect(HTTParty).to have_received(:get).with("https://example.com/getforecast/all", {
        query: {
          "zone" => "North London",
          "key" => "ABC123",
          "numdays" => 3,
          "from" => Date.today
        }
      })
    end
  end
end
