class Forecast
  attr_reader :obtained_at, :forecast_for, :zone, :air_pollution, :uv, :pollen, :temperature

  def initialize(attrs)
    @obtained_at = attrs.fetch(:obtained_at)
    @forecast_for = attrs.fetch(:forecast_for)
    @zone = attrs.fetch(:zone)
    @air_pollution = attrs.fetch(:air_pollution)
    @uv = attrs.fetch(:uv)
    @pollen = attrs.fetch(:pollen)
    @temperature = attrs.fetch(:temperature)
  end

  # :nocov:
  def inspect
    attr_values = [
      "@obtained_at=#{obtained_at}",
      "@forecast_for=#{forecast_for}",
      "@zone=#{zone.inspect}",
      "@air_pollution=#{air_pollution.inspect}",
      "@uv=#{uv}",
      "@pollen=#{pollen}",
      "@temperature=#{temperature.inspect}"
    ]

    "#<#{self.class.name} #{attr_values.join(" ")}>"
  end
  # :nocov:
end