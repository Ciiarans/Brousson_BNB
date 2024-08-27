class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :property, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.float :total_price
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.integer :number_of_guests
      t.string :status
      t.string :civility
      t.text :message

      t.timestamps
    end
  end
end
