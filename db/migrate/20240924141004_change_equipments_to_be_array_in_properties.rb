class ChangeEquipmentsToBeArrayInProperties < ActiveRecord::Migration[7.1]
  def change
    remove_column :properties, :equipments
    add_column :properties, :equipments, :text, array: true, default: []
  end
end
