class Reservation < ApplicationRecord
  has_one_attached :photo
  belongs_to :property
  validates :start_date, :end_date, :first_name, :last_name, :phone, :email, :number_of_guests, :status, :civility, presence: true
  validates :number_of_guests, numericality: { only_integer: true, greater_than: 0 }
  validates :status, inclusion: { in: %w(en_attente confirmée annulée) }
  validates :civility, inclusion: { in: %w(Mme Mr Mlle) }
  validate :no_overlapping_reservations

  private

  def no_overlapping_reservations
    # Rechercher les réservations qui chevauchent la période demandée pour la même propriété
    overlapping_reservations = Reservation.where(property_id: property_id)
                                          .where.not(id: id)
                                          .where("start_date < ? AND end_date > ?", end_date, start_date)

    # Si une réservation en conflit est trouvée, ajouter une erreur
    if overlapping_reservations.exists?
      errors.add(:base, "Il y a déjà une réservation pour cette période.")
    end
  end
  # validate :end_date_after_start_date
  # validate :start_date_not_in_past
  # validate :end_date_not_in_past
  # validate :start_date_not_blocked
  # validate :end_date_not_blocked
end
