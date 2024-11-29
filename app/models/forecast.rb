class Forecast
  include ActiveModel::Model

  attr_accessor :obtained_at, :date, :zone, :air_pollution, :uv, :pollen, :temperature

  def air_quality_alert?
    air_pollution[:label] != "LOW"
  end

  def share_message
    "On #{date.strftime("%A %d/%m/%Y")} the air pollution forecast for #{zone[:name]} is #{air_pollution[:label]} (#{air_pollution[:total]}/10). To learn more, visit https://airtext.info."
  end
end
