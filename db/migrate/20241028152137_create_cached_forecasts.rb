class CreateCachedForecasts < ActiveRecord::Migration[7.2]
  def change
    create_table :cached_forecasts, id: :uuid do |t|
      t.uuid :zone_id, null: false
      t.datetime :obtained_at, null: false
      t.jsonb :data, null: false

      t.timestamps
    end
    add_index :cached_forecasts, :zone_id
  end
end
