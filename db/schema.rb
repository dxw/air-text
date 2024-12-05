# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_12_05_174315) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cached_forecasts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "zone_id", null: false
    t.datetime "obtained_at", null: false
    t.jsonb "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["zone_id"], name: "index_cached_forecasts_on_zone_id"
  end

  create_table "verification_codes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code"
    t.datetime "expires_at", precision: nil
    t.string "target"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zone_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zones", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.integer "cerc_id", null: false
    t.integer "cerc_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.uuid "zone_group_id"
    t.index ["cerc_id"], name: "index_zones_on_cerc_id", unique: true
    t.index ["zone_group_id"], name: "index_zones_on_zone_group_id"
  end

  add_foreign_key "zones", "zone_groups"
end
