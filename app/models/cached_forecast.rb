class CachedForecast < ApplicationRecord
  self.implicit_order_column = "obtained_at"
  belongs_to :zone
  serialize :data

  def self.stale?
    if (latest_record = last)
      threshold = Time.current - ENV.fetch("CERC_API_CACHE_LIMIT_MINS").to_i.minutes
      return latest_record.obtained_at < threshold
    end

    true
  end

  def self.latest_for(zone)
  end

  def self.store(built_forecasts)
    zone = Zone.find_by(cerc_id: built_forecasts.first.zone.id)
    obtained_at = built_forecasts.first.obtained_at

    create(
      zone: zone,
      obtained_at: obtained_at,
      data: built_forecasts
    )
  end
end
