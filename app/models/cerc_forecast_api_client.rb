class CercForecastApiClient
  class << self
    def latest_forecasts(zone = nil)
      query = {
        "from" => Date.today,
        "numdays" => 3,
        "zone" => zone
      }.compact

      request("getforecast/all", query)
    end

    private

    def request(endpoint, query = {})
      base_url = ENV.fetch("CERC_FORECAST_API_HOST_URL")
      headers = {"x-api-key" => ENV.fetch("CERC_FORECAST_API_KEY")}
      HTTParty.get("#{base_url}/#{endpoint}", headers: headers, query: query)
    end
  end
end
