class Property < ApplicationRecord
  has_one_attached :first_image
  has_many_attached :photos
  has_many :reviews, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many :reservations, dependent: :destroy


  validates :title, :description, :capacity, :bedrooms, :bathrooms, :price_per_night, :address, :equipments, presence: true
  validates :capacity, :bedrooms, :bathrooms, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_night, numericality: { greater_than: 0 }
  validates :title, length: { minimum: 5 }
  validates :square_meters, presence: true, numericality: { greater_than: 0 }
  validates :cleaning_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :description , length: { minimum: 20 }

end
