# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_12_015659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rentals", force: :cascade do |t|
    t.bigint "vinyl_id", null: false
    t.bigint "user_id", null: false
    t.string "status", default: "Pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "start_date"
    t.date "end_date"
    t.index ["user_id"], name: "index_rentals_on_user_id"
    t.index ["vinyl_id"], name: "index_rentals_on_vinyl_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.string "user_photo"
    t.boolean "admin", default: false
    t.string "address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vinyls", force: :cascade do |t|
    t.string "title"
    t.string "genre"
    t.string "artist_api_id"
    t.string "album_api_id"
    t.string "artist"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_url"
    t.integer "price"
    t.string "cover"
    t.string "cover_small"
    t.string "cover_medium"
    t.string "cover_big"
    t.string "cover_xl"
    t.string "image_url"
    t.string "status"
    t.index ["user_id"], name: "index_vinyls_on_user_id"
  end

  add_foreign_key "rentals", "users"
  add_foreign_key "rentals", "vinyls"
  add_foreign_key "vinyls", "users"
end
