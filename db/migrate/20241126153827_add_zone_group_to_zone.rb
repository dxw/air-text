class AddZoneGroupToZone < ActiveRecord::Migration[7.2]
  def change
    add_reference :zones, :zone_group, type: :uuid, foreign_key: true
  end
end
