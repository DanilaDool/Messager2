# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_20_141833) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friends", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "requester_id"
    t.integer "requested_id"
    t.string "status"
    t.boolean "accepted"
    t.boolean "sent_request"
  end

  create_table "homes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_likes_on_message_id"
    t.index ["user_id", "message_id"], name: "index_likes_on_user_id_and_message_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.string "image"
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_rooms_on_title"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "rooms_users", id: false, force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "user_id"
    t.index ["room_id", "user_id"], name: "index_rooms_users_on_room_id_and_user_id", unique: true
    t.index ["room_id"], name: "index_rooms_users_on_room_id"
    t.index ["user_id"], name: "index_rooms_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "avatar"
    t.string "name"
    t.string "descriptions"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "likes", "messages"
  add_foreign_key "likes", "users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "rooms", "users"
end
