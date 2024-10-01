class ForecastsController < ApplicationController
  def show
    forecast_response = CercApiClient.fetch_data(params.has_key?("zone") ? params["zone"] : "Southwark")
    @forecast = JSON.parse(forecast_response.body)["zones"][0]

    @dates = @forecast["forecasts"].map { |day_forecast| day_forecast["forecast_date"] }

    @zones = JSON.parse(File.read("#{Rails.root}/config/list-of-zones.json"))
  end
end
