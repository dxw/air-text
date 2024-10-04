require "httparty"

class CercApiClient
  include HTTParty

  def self.fetch_data(zone)
    base_url = ENV.fetch("CERC_API_HOST_URL")

    query = {
      "from" => Date.today,
      "numdays" => 3,
      "zone" => zone,
      "key" => ENV.fetch("CERC_API_KEY")
    }

    HTTParty.get("#{base_url}/getforecast/all", query: query)
  end
end
