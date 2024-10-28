class PropertiesController < ApplicationController
  before_action :load_equipment_categories, only: [:new, :create, :show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @properties = Property.all
    @markers = @properties.geocoded.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
      }
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
    @reservation = Reservation.new
        @address = @property.address
  end

  def new
      @property = Property.new
  end

  def create
        @property = Property.new(property_params)
    @property.user = current_user
    if @property.save
      redirect_to property_path(@property)
    else
      render :new
    end
    # Envoi des confirmations
    if @property.save
      flash[:notice] = "Votre logement a bien été ajouté."
      redirect_to property_path(@property)
    else
      flash[:alert] = "Votre logement n'a pas pu être ajouté : #{@property.errors.full_messages.join(", ")}"
      redirect_to new_property_path
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
        "Divertissement" => ["Télévision", "Livres et de quoi lire"],
        "Famille" => ["Lit pour bébé", "Standard (1,3 m de long sur 70 cm de large)", "Lit parapluie : disponible sur demande"],
        "Chauffage et climatisation" => ["Chauffage central", "Climatisation"],
        "Sécurité à la maison" => ["Détecteur de fumée", "Extincteur", "Kit de premiers secours","Coffre-fort", "Serrure numérique","caméra de surveillance"],
        "Internet et bureau" => ["Wifi", "Espace de travail dédié", "Dans un espace commun"],
        "Cuisine et salle à manger" => ["Cuisine", "Espace où les voyageurs peuvent cuisiner", "Four à micro-ondes", "Équipements de cuisine de base", "Casseroles et poêles, huile, sel et poivre", "Vaisselle et couverts", "Congélateur", "Lave-vaisselle", "Four en acier inoxydable", "Bouilloire électrique", "Cafetière", "Verres à vin", "Grille-pain", "Plaque de cuisson", "Blender", "Table à manger"],
        "Caractéristiques de l'emplacement" => ["Les voyageurs peuvent profiter d'une plage à proximité"],
        "Extérieur" => ["Privé : patio ou balcon", "Mobilier d'extérieur", "Espace repas en plein air"],
        "Parking et installations" => ["Parking gratuit sur place", "Parking gratuit dans la rue", "Ascenseur", "Logement de plain-pied", "Pas d'escaliers dans le logement"],
        "Services" => ["Ménage disponible pendant le séjour"],
        "Non inclus" => ["Caméras de surveillance", "Détecteur de monoxyde de carbone","climatisation"]
      }
  end


  def property_params
    params.require(:property).permit(:title, :address, :description, :price_per_night, :capacity, :bedrooms, :bathrooms, :image, equipments: [], photos: [])
  end

end
