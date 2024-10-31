class ForecastsController < ApplicationController
  def show
    @forecasts = CercForecastService.latest_forecasts_for(zone).data
    @zones = Zone.order(name: :asc).pluck(:name, :cerc_id)
    @air_quality_alerts = @forecasts.map(&:alerts).flatten
  end

  private

  def zone
    return Zone.default unless params[:zone]

    Zone.find_by(cerc_id: params[:zone])
  end
end
