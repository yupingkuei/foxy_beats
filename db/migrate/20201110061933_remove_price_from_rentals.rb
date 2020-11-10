class RemovePriceFromRentals < ActiveRecord::Migration[6.0]
  def change
    remove_column :rentals, :price
  end
end
