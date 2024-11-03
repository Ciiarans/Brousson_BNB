class AddSquareMetersAndCleaningPriceToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :square_meters, :integer
    add_column :properties, :cleaning_price, :decimal
  end
end
