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
# Créer des réservations
# Créer des logements
properties = []
12.times do
  property = Property.create!(
    user: users.sample, # Attribuer un utilisateur au hasard
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph,
    capacity: Faker::Number.between(from: 1, to: 10),
    bedrooms: Faker::Number.between(from: 1, to: 5),
    bathrooms: Faker::Number.between(from: 1, to: 5),
    price_per_night: Faker::Commerce.price(range: 50..500),
    address: Faker::Address.full_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    equipments: Array.new(Faker::Number.between(from: 1, to: 5)) { Faker::Lorem.word }, # Liste d'équipements
    square_meters: Faker::Number.between(from: 20, to: 200),
    cleaning_price: Faker::Commerce.price(range: 10..50),
  )

  # Générer une image aléatoire avec Faker
  image_url = Faker::Avatar.image(size: "500x500", format: "jpg")

  # Télécharger l'image et l'attacher à la propriété
  property.first_image.attach(io: URI.open(image_url), filename: "property_#{property.id}_main.jpg")

  # Ajouter plusieurs photos à la propriété avec Faker
  7.times do |i|
    photo_url = Faker::Avatar.image(size: "500x500", format: "jpg")
    property.photos.attach(io: URI.open(photo_url), filename: "property_#{property.id}_photo_#{i + 1}.jpg")
  end

  properties << property
end
puts "#{Property.count} propriétés créés."

puts "Seed terminée avec succès ! #{User.count} utilisateurs, #{Property.count} propriétés, et #{Reservation.count} réservations créés."
