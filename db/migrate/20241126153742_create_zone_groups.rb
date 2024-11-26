class CreateZoneGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :zone_groups, id: :uuid do |t|
      t.string :name
      t.text :description
      t.integer :order

      t.timestamps
    end
  end
end
