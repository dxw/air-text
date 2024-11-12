class CercApiClient
  class << self
    def latest_forecasts(zone = nil)
      base_url = ENV.fetch("CERC_API_HOST_URL")

      query = {
        "from" => Date.today,
        "numdays" => 3,
        "zone" => zone,
        "key" => ENV.fetch("CERC_API_KEY")
      }.compact

      HTTParty.get("#{base_url}/getforecast/all", query: query)
    end
  end
end
