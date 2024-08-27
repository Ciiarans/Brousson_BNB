class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :capacity
      t.integer :bedrooms
      t.integer :bathrooms
      t.float :price_per_night
      t.string :address
      t.text :equipments
      t.timestamps
    end
  end
end
