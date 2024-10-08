class Forecast
  attr_reader :obtained_at, :date, :zone, :air_pollution, :uv, :pollen, :temperature

  def initialize(attrs)
    @obtained_at = attrs.fetch(:obtained_at)
    @date = attrs.fetch(:date)
    @zone = attrs.fetch(:zone)
    @air_pollution = attrs.fetch(:air_pollution)
    @uv = attrs.fetch(:uv)
    @pollen = attrs.fetch(:pollen)
    @temperature = attrs.fetch(:temperature)
  end

  def alerts
    [air_quality_alert].compact
  end

  def air_quality_alert
    return if air_pollution.daqi_level == :low

    AirQualityAlert.new(self)
  end

  # :nocov:
  def inspect
    attr_values = [
      "@obtained_at=#{obtained_at}",
      "@date=#{date}",
      "@zone=#{zone.inspect}",
      "@air_pollution=#{air_pollution.inspect}",
      "@uv=#{uv.inspect}",
      "@pollen=#{pollen}",
      "@temperature=#{temperature.inspect}"
    ]

    "#<#{self.class.name} #{attr_values.join(" ")}>"
  end
  # :nocov:
end
