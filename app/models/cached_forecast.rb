class CachedForecast < ApplicationRecord
  self.implicit_order_column = "obtained_at"
  belongs_to :zone
  serialize :data

  scope :latest_for, ->(zone) { where("zone_id = ?", zone.id).last }
  scope :latest_for_all_zones, -> {
    select("DISTINCT ON (zone_id) *")
      .order(:zone_id, obtained_at: :desc)
  }

  validates :obtained_at, :zone, :data, presence: true
  validate :data_is_complete?

  def data_is_complete?
    errors.add(:data, "must be an array of three forecasts") unless data.is_a?(Array) && data.size == 3

    data&.each do |forecast|
      errors.add(:data, "forecasted_at must be a date") unless forecast.air_pollution[:forecasted_at].is_a?(Time)

      %i[no2 pm10 pm2_5 o3 total].each do |pollutant|
        errors.add(:data, "#{pollutant} must be an integer") unless forecast.air_pollution[pollutant].is_a?(Integer)
      end

      errors.add(:data, "label must be one of the expected values") unless Forecast::AIR_POLLUTION_LABELS.include?(forecast.air_pollution[:label])

      %i[uv pollen].each do |pollutant|
        errors.add(:data, "#{pollutant} must be an integer") unless forecast.send(pollutant).is_a?(Integer)
      end

      %i[min max].each do |temp|
        errors.add(:data, "temperature.#{temp} must be a number") unless forecast.temperature[temp].is_a?(Numeric)
      end
    end
  end

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
    create!(
      zone: Zone.find_by(cerc_id: built_forecasts.first.zone[:id]),
      obtained_at: built_forecasts.first.obtained_at,
      data: built_forecasts
    )
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Failed to store forecast: #{e.message}")
  end
end
