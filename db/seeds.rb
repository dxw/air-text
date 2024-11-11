# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Seed zones
file_data = File.read(Rails.root.join("db", "fixtures", "01_zones.json"))
zones = JSON.parse(file_data, symbolize_names: true)

zones.each do |zone|
  Zone.seed(:cerc_id) do |s|
    s.name = zone[:name]
    s.cerc_id = zone[:cerc_id]
    s.cerc_type = zone[:cerc_type]
  end
end
