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

# Créer des propriétés
properties = []
7.times do |i|
  properties << Property.create!(
    user: users.sample,
    title: " #{Faker::Lorem.words(number: 3).join(' ')}",
    description: Faker::Lorem.paragraph(sentence_count: 10),
    capacity: rand(2..6),
    bedrooms: rand(1..3),
    bathrooms: rand(1..2),
    price_per_night: rand(50..200),
    address: Faker::Address.street_address,
    equipments: %w[WiFi Cuisine Climatisation Chauffage Parking Animaux].sample(rand(2..6)).join(', '),
    created_at: Time.now,
    updated_at: Time.now
  )
end

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
    civility: %w[M. Mme Mlle].sample,
    message: Faker::Lorem.paragraph(sentence_count: 3),
    created_at: Time.now,
    updated_at: Time.now
  )
end

puts "Seed terminée avec succès ! #{User.count} utilisateurs, #{Property.count} propriétés, et #{Reservation.count} réservations créés."
