class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.references :vinyl, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :price
      t.string :start_date
      t.string :end_date
      t.string :status, default: "Pending"

      t.timestamps
    end
  end
end
