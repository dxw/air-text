class ZoneGroup < ApplicationRecord
  has_many :zones

  validates :name, presence: true, uniqueness: true
end
