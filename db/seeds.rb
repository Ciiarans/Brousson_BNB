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

User.create!(
  email: ENV['SITE_KEY'],
  password: ENV['SECRET_KEY'],
  password_confirmation: ENV['SECRET_KEY']
)
