class Zone < ApplicationRecord
  belongs_to :zone_group

  DEFAULT_ZONE_CENTRAL_LONDON_CERC_ID = 55

  def self.default
    find_by!(cerc_id: DEFAULT_ZONE_CENTRAL_LONDON_CERC_ID)
  end
end
