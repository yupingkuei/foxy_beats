class AddStatusToVinyls < ActiveRecord::Migration[6.0]
  def change
    add_column :vinyls, :status, :string
  end
end
