class ReservationsController < ApplicationController
  before_action :set_property, only: [:new, :create]
  before_action :set_reservation, only: [:update]

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.property = @property
    @reservation.total_price = @property.price_per_night * (@reservation.end_date - @reservation.start_date).to_i
    @reservation.status = "en_attente"

    # Upload de la photo si elle est présente
    if params[:reservation][:photo]
      uploaded_file = params[:reservation][:photo]
      begin
        # Uploader la photo vers Cloudinary
        upload_response = Cloudinary::Uploader.upload(uploaded_file.tempfile.path, resource_type: :raw)
        photo_url = upload_response['secure_url'] # Récupérer l'URL sécurisée
      rescue => e
        flash[:alert] = "L'upload de la photo a échoué : #{e.message}"
        redirect_to property_path(@property) and return
      end
    end

    if @reservation.save
      flash[:notice] = "Votre réservation a bien été prise en compte. Un mail vous sera envoyé pour confirmer votre réservation"
      redirect_to properties_path
    else
      flash[:alert] = "Votre réservation n'a pas pu être prise en compte"
      redirect_to property_path(@property)
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
    params.require(:reservation).permit(:start_date, :end_date, :first_name, :last_name, :phone, :email, :number_of_guests, :status, :civility, :message, :photo, :total_price)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

end
