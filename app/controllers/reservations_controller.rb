class ReservationsController < ApplicationController
  before_action :set_property, only: [:new, :create]

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.property = @property
    @reservation.total_price = @property.price * (@reservation.end_date - @reservation.start_date).to_i
    @reservation.status = "pending"
    if @reservation.save
      redirect_to properties_path flash[:notice] = "Votre réservation a bien été prise en compte. Un mail vous a été envoyé avec les détails"
    else
      render :new
      flash[:alert] = "Votre réservation n'a pas pu être prise en compte"
    end
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :first_name, :last_name, :phone, :email, :number_of_guests, :status, :civility, :message)
  end
end
