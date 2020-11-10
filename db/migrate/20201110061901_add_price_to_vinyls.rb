class AddPriceToVinyls < ActiveRecord::Migration[6.0]
  def change
    add_column :vinyls, :price, :integer
  end
end
