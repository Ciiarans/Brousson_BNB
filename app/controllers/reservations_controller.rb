class ReservationsController < ApplicationController
  before_action :set_property, only: [:new, :create]
  before_action :set_reservation, only: [:update]
  before_action :authenticate_user!, only: [:destroy]

  def new
    @reservation = Reservation.new


  end

  def create
    @property = Property.find(params[:property_id]) # Assurez-vous que vous avez accès à @property
    @reservation = Reservation.new(reservation_params)
    @reservation.property = @property
    @reservation.start_date = Date.strptime(params[:start_date], '%Y-%m-%d') rescue nil
    @reservation.end_date = Date.strptime(params[:end_date], '%Y-%m-%d') rescue nil

    # Gestion du ménage
    if params[:reservation][:add_cleaning] == '1' # '1' si coché
      @reservation.total_price = params[:total_price].to_f + @cleaning # Ajout du prix de ménage au prix total
      @reservation.add_cleaning = true
    else
      @reservation.total_price = params[:total_price].to_f
      @reservation.add_cleaning = false
    end

    @reservation.status = "en_attente"

    # Upload de la photo si elle est présente
    if params[:reservation][:photo]
      # ... (le reste de ton code pour uploader la photo)
    end

    if @reservation.save
      flash[:notice] = "Votre réservation a bien été prise en compte."
      redirect_to properties_path
    else
      flash[:alert] = "Votre réservation n'a pas pu être prise en compte : #{@reservation.errors.full_messages.join(", ")}. Veuillez vérifier les champs manquants et réessayer."
      redirect_to property_path(@property), status: :unprocessable_entity
    end
  end




  def update
    if @reservation.update(status: params[:reservation][:status])
      redirect_to profile_path, notice: 'Réservation mise à jour avec succès.'
    else
      redirect_to profile_path, alert: 'Erreur lors de la mise à jour de la réservation.'
    end

  end

  def destroy
      @reservation = Reservation.find(params[:id]) # Assurez-vous que l'ID est bien celui de la réservation
      @reservation.destroy
    redirect_to profile_path
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :first_name, :last_name, :phone, :email, :number_of_guests, :status, :civility, :message, :photo, :total_price, :add_cleaning)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

end
