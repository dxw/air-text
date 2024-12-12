class CachedForecast < ApplicationRecord
  self.implicit_order_column = "obtained_at"
  belongs_to :zone
  serialize :data

  scope :latest_for, ->(zone) { where("zone_id = ?", zone.id).last }
  scope :latest_for_all_zones, -> {
    select("DISTINCT ON (zone_id) *")
      .order(:zone_id, obtained_at: :desc)
  }

  def pollutant_forecasts(pollutant)
    data.map { |f| f.air_pollution[pollutant.downcase.to_sym] }
  end

  def self.stale?
    latest_record = last

    return true if latest_record.nil?

    threshold = Time.current - ENV.fetch("CERC_FORECAST_API_CACHE_LIMIT_MINS").to_i.minutes
    latest_record.obtained_at < threshold
  end

  def self.store(built_forecasts)
    create(
      zone: Zone.find_by(cerc_id: built_forecasts.first.zone[:id]),
      obtained_at: built_forecasts.first.obtained_at,
      data: built_forecasts
    )
  end
end
