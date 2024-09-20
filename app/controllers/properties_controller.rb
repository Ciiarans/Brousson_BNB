class PropertiesController < ApplicationController

  def index
    @properties = Property.all
    @markers = @properties.geocoded.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
      }
    end
  end

  def show
    @property = Property.find(params[:id])
    @reservation = Reservation.new
    @address = @property.address
  end
  def new
      @property = Property.new
      @equipment_categories = {
        "Chambre et linge" => ["Salle de bain", "Sèche-cheveux", "Eau chaude", "Chambre et linge", "Lave-linge (Gratuit) dans le logement", "Sèche-linge (Gratuit)", "Équipements de base", "Serviettes, draps, savon et papier toilette", "Cintres", "Draps", "Linge de lit en coton", "Oreillers et couvertures supplémentaires", "Stores", "Fer à repasser", "Étendoir à linge", "Espace de rangement pour les vêtements : dressing"],
        "Divertissement" => ["Télévision", "Livres et de quoi lire", "Minigolf"],
        "Famille" => ["Lit pour bébé", "Standard (1,3 m de long sur 70 cm de large)", "Lit parapluie : disponible sur demande"],
        "Chauffage et climatisation" => ["Chauffage central", "Climatisation"],
        "Sécurité à la maison" => ["Détecteur de fumée"],
        "Internet et bureau" => ["Wifi", "Espace de travail dédié", "Dans un espace commun"],
        "Cuisine et salle à manger" => ["Cuisine", "Espace où les voyageurs peuvent cuisiner", "Four à micro-ondes", "Équipements de cuisine de base", "Casseroles et poêles, huile, sel et poivre", "Vaisselle et couverts", "Congélateur", "Lave-vaisselle", "Four en acier inoxydable", "Bouilloire électrique", "Cafetière", "Verres à vin", "Grille-pain", "Plaque de cuisson", "Blender", "Table à manger"],
        "Caractéristiques de l'emplacement" => ["Accès partagé à la plage – Bord de mer", "Les voyageurs peuvent profiter d'une plage à proximité"],
        "Extérieur" => ["Privé : patio ou balcon", "Mobilier d'extérieur", "Espace repas en plein air"],
        "Parking et installations" => ["Parking gratuit sur place", "Parking gratuit dans la rue", "Ascenseur", "Logement de plain-pied", "Pas d'escaliers dans le logement"],
        "Services" => ["Ménage disponible pendant le séjour"],
        "Non inclus" => ["Caméras de surveillance", "Détecteur de monoxyde de carbone"]
    }
  end
  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to properties_path
    else
      render :new
    end
  end

  private

  def property_params
    params.require(:property).permit(:name, :address, :description, :price, :number_of_guests, :number_of_bedrooms, :number_of_bathrooms, :equipments)
  end
end
