class ForecastsController < ApplicationController
  def show
    @forecasts = CercApiClient
      .forecasts_for(params.has_key?("zone") ? params["zone"] : "Southwark")
    @zones = JSON.parse(File.read("#{Rails.root}/config/list-of-zones.json"))
    @air_quality_alerts = @forecasts.map(&:alerts).flatten
  end
end
