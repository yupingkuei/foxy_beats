class RemoveGenreFromVinyls < ActiveRecord::Migration[6.0]
  def change
    remove_column :vinyls, :genre
    add_column :vinyls, :condition, :string
  end
end
