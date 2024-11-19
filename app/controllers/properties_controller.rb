class PropertiesController < ApplicationController
  before_action :load_equipment_categories, only: [:new, :create, :show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  require 'json'
  def index
    @properties = Property.all
    @markers = @properties.geocoded.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
      }
    end
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])

      # On filtre les propriétés dont la date de réservation ne chevauche pas la plage demandée
      @properties = @properties.reject do |property|
        property.reservations.any? do |reservation|
          reservation.start_date < end_date && reservation.end_date > start_date
        end
      end
    end
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    @property.update(property_params)
    redirect_to property_path(@property)
  end

  def show
    @property = Property.find(params[:id])
    if @property.cleaning_price && @property.square_meters > 0
      @cleaning = @property.cleaning_price * @property.square_meters
    end
    @reserved_ranges = @property.reservations.map do |reservation|
      { from: reservation.start_date.to_s, to: reservation.end_date.to_s }
    end
    @reserved_ranges = @reserved_ranges.to_json
    @reservation = Reservation.new
    @address = @property.address
    @address = @property.address
  end

  def new
      @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @property.user = current_user
    if @property.save
      flash[:notice] = "Votre logement a bien été ajouté."
      redirect_to property_path(@property)
    else
      flash[:alert] = "Votre logement n'a pas pu être ajouté : #{@property.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to profile_path
  end

  private

  def load_equipment_categories
    @equipment_categories = {"Chambre et linge" => ["Sèche-cheveux","Lave-linge (Gratuit) dans le logement", "Sèche-linge (Gratuit)", "Équipements de base (Serviettes, draps, savon et papier toilette)", "Cintres", "Oreillers et couvertures supplémentaires","Fer à repasser", "Étendoir à linge", "Espace de rangement pour les vêtements : dressing"],
        "Divertissement" => ["Téléviseur", "Livres"],
        "Famille" => ["Lit pour bébé", "Standard (1,3 m de long sur 70 cm de large)", "Lit parapluie : disponible sur demande"],
        "Chauffage et climatisation" => ["Chauffage central", "Climatisation"],
        "Sécurité du logement" => ["Détecteur de fumée", "Extincteur","Coffre-fort", "Serrure numérique","Caméra de surveillance","Accés handicapé"],
        "Internet et bureau" => ["Wifi", "Espace de travail dédié"],
        "Cuisine et salle à manger" => ["Cuisine","Condiments de base", "Espace pour cuisiner", "Four à micro-ondes", "Casseroles et poêles", "Vaisselle et couverts", "Congélateur", "Lave-vaisselle", "Four en acier inoxydable", "Bouilloire électrique", "Cafetière à filtre","Cafetière à capsules", "Verres à vin", "Grille-pain", "Plaque de cuisson", "Blender", "Table à manger"],
        "Caractéristiques de l'emplacement" => ["Golf","Piscine","Parc","Centre-ville","Plage","transports en commun","Aéroport","Gare","Commerces et restaurants à proximité"],
        "Extérieur" => ["Privé : patio ou balcon", "Mobilier d'extérieur", "Espace repas en plein air","Barbecue","Plancha","Jacuzzi","Salon d'été","Jardin ou arrière-cour","Piscine privée"],
        "Parking et installations" => ["Parking gratuit sur place", "Parking gratuit dans la rue", "Ascenseur", "Logement de plain-pied", "Pas d'escaliers dans le logement"],
        "Services" => ["Ménage disponible pendant le séjour à la demande"],
        "Non inclus" => ["Caméras de surveillance", "Détecteur de monoxyde de carbone","climatisation", "Kit de premiers secours","Accés handicapé","Coffre-fort"]
      }
  end


  def property_params
    params.require(:property).permit(:title, :address, :description, :price_per_night, :capacity, :bedrooms, :bathrooms, :first_image, :square_meters, :cleaning_price, equipments: [], photos: [])
  end


end
