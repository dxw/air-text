class CreateZones < ActiveRecord::Migration[7.2]
  def change
    create_table :zones, id: :uuid do |t|
      t.string :name, null: false
      t.integer :cerc_id, null: false
      t.integer :cerc_type, null: false

      t.timestamps
    end
    add_index :zones, :cerc_id, unique: true
  end
end
