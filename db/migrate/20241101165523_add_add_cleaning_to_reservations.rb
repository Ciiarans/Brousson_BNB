class AddAddCleaningToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :add_cleaning, :boolean
  end
end
