class CreateVinyls < ActiveRecord::Migration[6.0]
  def change
    create_table :vinyls do |t|
      t.string :title
      t.string :genre
      t.string :artist_api_id
      t.string :album_api_id
      t.string :artist
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
