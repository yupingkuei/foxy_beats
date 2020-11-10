class AddCoverToVinyls < ActiveRecord::Migration[6.0]
  def change
    add_column :vinyls, :cover, :string
    add_column :vinyls, :cover_small, :string
    add_column :vinyls, :cover_medium, :string
    add_column :vinyls, :cover_big, :string
    add_column :vinyls, :cover_xl, :string
  end
end
