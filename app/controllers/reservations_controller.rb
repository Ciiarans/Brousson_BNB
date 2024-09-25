class ReservationsController < ApplicationController
  before_action :set_property, only: [:new, :create]
  before_action :set_reservation, only: [:update]

  def new
    @reservation = Reservation.new

  end


  def create

    @reservation = @property.reservations.build(reservation_params)

    @reservation.property = @property

    @reservation.status = "en_attente"
    @reservation.total_price = @property.price_per_night * (@reservation.end_date - @reservation.start_date).to_i
    if @reservation.save

      redirect_to property_path(@property), notice: "Votre réservation a bien été prise en compte. Un mail vous sera envoyé pour confirmer votre réservation"
    else
      redirect_to property_path(@property), alert: "Votre réservation n'a pas pu être prise en compte"

    end
  end

  def update
    if @reservation.update(status: params[:reservation][:status])
      redirect_to profile_path, notice: 'Réservation mise à jour avec succès.'
    else
      redirect_to profile_path, alert: 'Erreur lors de la mise à jour de la réservation.'
    end

  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :first_name, :last_name, :phone, :email, :number_of_guests, :status, :civility, :message, :total_price)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

end
