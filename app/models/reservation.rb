class Reservation < ApplicationRecord
  has_one_attached :photo
  belongs_to :property
  validates :start_date, :end_date, :first_name, :last_name, :phone, :email, :number_of_guests, :status, :civility, presence: true
  validates :number_of_guests, numericality: { only_integer: true, greater_than: 0 }
  validates :status, inclusion: { in: %w(en_attente confirmée annulée) }
  validates :civility, inclusion: { in: %w(Mme Mr Mlle) }




  # validate :end_date_after_start_date
  # validate :start_date_not_in_past
  # validate :end_date_not_in_past
  # validate :start_date_not_blocked
  # validate :end_date_not_blocked
end
