# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Vider les tables pour éviter les doublons lors des re-seeds
Property.destroy_all
Reservation.destroy_all
User.destroy_all

# Créer des utilisateurs
users = []
1.times do |i|
  users << User.create!(
    email: "user#{i + 1}@exemple.com",
    password: 'password',
    password_confirmation: 'password'
  )
end
properties = []
# Créer des propriétés
 properties << Property.create!(
  user: users.first,
  title: 'T4 de standing vue ocean Biarritz',
  description: "Appartement cosy niché dans un havre de paix !
Situé au calme, à deux pas du centre ville, et 10min à pied de l'océan.
La résidence est sécurisée, place de parking disponible, parc de 2ha.
Salle de fitness et superette dans la résidence.
Nombreux commerces, transports commun, et restaurants à proximité.
L'appartement se compose de 2 chambres avec lits 160 + une annexe desservant un canapé lit de 160.
Salon spacieux, cuisine fermée tout équipée avec une agréable terrasse.",
  capacity: 6,
  bedrooms: 3,
  bathrooms: 2,
  price_per_night: 210,
  address: 'Biarritz, Nouvelle-Aquitaine, France',
  equipments: ["Vue sur l'océan, lave-linge, télévision, wifi, espace de travail dédié, wifi, cuisine, parking gratuit sur place, salle de sport, espace repas en plein air"])

  properties <<  Property.create!(
    user: users.first,
    title: "Superbe T4 2mn à pied de l'océan",
    description: "Profitez en famille de ce fabuleux logement qui offre de bons moments en perspective.Superbe apt T4 en RDC avec jardin.
Situation privilégiée, à 5min à pied de l'océan, des commerces des 5 cantons, et du phare de Biarritz.
Transports en commun à proximité. Il se compose d'une cuisine ouverte sur salon et SAM, 4 chambres (dont une suite parentale avec salle de douche et wc), salle de bain.Terrasses couvertes et loggias aménagées. Parking privé dans la résidence",
    capacity: 7,
    bedrooms: 4,
    bathrooms: 2,
    price_per_night: 385,
    address: 'Anglet, Nouvelle-Aquitaine, France',
    equipments: ["Piscine, Climatisation, Wifi, Parking, Barbecue"])

    properties <<  Property.create!(
      user: users.first,
      title: 'Appartement de standing ocean Anglet/Biarritz',
      description: "Appartement de standing tout proche de la plage du VVF et du phare de Biarritz Logement chic au décor raffiné doté d'un mobilier de haut de gamme.appartement très lumineux.
trés belle terrasse donnant sur le parcours du golf le phare . Appartement proche de tous commerces et restaurants . IL possède 2 parkings gratuits.
pour les amoureux du surf et de la cote basque",
      capacity: 6,
      bedrooms: 3,
      bathrooms: 2,
      price_per_night: 200,
      address: '16, Anglet, Nouvelle-Aquitaine, France',
      equipments: ["Lave-linge, climatisation, détecteur de fumée, espace de travail dédié, wifi, cuisine, réfrigérateur, cafetière, parking, patio ou balcon, accès plage ou bord de mer"])

      properties <<    Property.create!(
        user: users.first,
        title: 'Appart de standing Biarritz Anglet plage',
        description: 'Très bel appartement de standing de 94m², situation priviligiée sur Anglet : A deux pas de Biarritz, de la plage du VVF et de la place des 5 cantons.
Nombreux commerces, lignes de bus, restaurants à proximité.
Il se compose d’un spacieux salon desservant une cuisine américaine toute équipée ; deux agréables terrasse ; deux chambres dont une avec lit en 160 cm et l’autre 2 lits jumeaux en 80 avec rangements ; deux salles d’eau.
Meublé de tourisme 3***',
        capacity: 4,
        bedrooms: 2,
        bathrooms: 2,
        price_per_night: 380,
        address: '18, Anglet, Nouvelle-Aquitaine, France',
        equipments: ["Sèche-cheveux, lave-linge, sèche-linge, télévision, minigolf, lit pour bébé, détecteur de fumée, wifi, espace de travail dédié, cuisine, micro-ondes, accès à la plage, parking, logement de plein pied "])

# Créer des réservations
10.times do
  Reservation.create!(
    property: properties.sample,
    start_date: Faker::Date.between(from: '2024-09-01', to: '2024-12-31'),
    end_date: Faker::Date.between(from: '2024-10-01', to: '2025-01-31'),
    total_price: rand(300..1500),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    number_of_guests: rand(1..6),
    status: %w[confirmée annulée en_attente].sample,
    civility: %w[M Mme Mlle].sample,
    message: Faker::Lorem.paragraph(sentence_count: 3),
    created_at: Time.now,
    updated_at: Time.now
  )
end

puts "Seed terminée avec succès ! #{User.count} utilisateurs, #{Property.count} propriétés, et #{Reservation.count} réservations créés."
