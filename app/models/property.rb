class Property < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  validates :title, :description, :capacity, :bedrooms, :bathrooms, :price_per_night, :address, :equipments, presence: true
  validates :capacity, :bedrooms, :bathrooms, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_night, numericality: { greater_than: 0 }
  validates :title, length: { minimum: 5 }
  validates :description, length: { minimum: 10 }
  validates :equipments, length: { minimum: 10 }
  # validate :price_per_night_is_multiple_of_5
  # validate :address_is_valid
end