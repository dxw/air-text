class CachedForecast < ApplicationRecord
  self.implicit_order_column = "obtained_at"
  belongs_to :zone
  serialize :data

  scope :latest_for, ->(zone) { where("zone_id = ?", zone.id).last }

  def self.stale?
    latest_record = last

    return true if latest_record.nil?

    threshold = Time.current - ENV.fetch("CERC_API_CACHE_LIMIT_MINS").to_i.minutes
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
