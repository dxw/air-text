require "httparty"

class CercApiClient
  include HTTParty

  BASE_URL = "https://london-airtext-forecasts-api-gateway-7x54d7qf.nw.gateway.dev"

  def self.fetch_data(zone)
    query = {
      "from" => Date.today,
      "numdays" => 3,
      "zone" => zone,
      "key" => ENV["CERC_API_KEY"]
    }

    HTTParty.get("#{BASE_URL}/getforecast/all", query: query)
  end
end
