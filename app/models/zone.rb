class Zone < ApplicationRecord
  DEFAULT_ZONE_SOUTHWARK_CERC_ID = 29

  def self.default
    find_by!(cerc_id: DEFAULT_ZONE_SOUTHWARK_CERC_ID)
  end
end
