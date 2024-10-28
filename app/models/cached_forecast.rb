class CachedForecast < ApplicationRecord
  belongs_to :zone

  def self.stale?
  end

  def self.latest_for(zone)
  end

  def self.store(built_forecasts)
    zone = Zone.find_by(cerc_id: built_forecasts.first.zone.id)
    obtained_at = built_forecasts.first.obtained_at

    create(
      zone: zone,
      obtained_at: obtained_at
    )
  end
end
