# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_16_041830) do

  create_table "addresses", force: :cascade do |t|
    t.string "area", null: false
    t.text "text", null: false
    t.integer "prefecture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "real_estate_id"
    t.integer "real_estate_erea", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_real_estates", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "real_estate_id"
    t.integer "pieces"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer "prefecture_id"
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "first_name_kana"
    t.string "last_name_kana"
    t.string "postal_code"
    t.string "address"
    t.string "tel"
    t.string "jobs"
    t.string "seriousness"
    t.integer "moving_date"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "real_estate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "name"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "negotiates", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "real_estate_id"
    t.integer "negotiation_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visiter_id"
    t.integer "visited_id"
    t.integer "real_estate_id"
    t.string "action"
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_real_estates", force: :cascade do |t|
    t.integer "order_id"
    t.integer "real_estate_id"
    t.integer "tax_price"
    t.integer "negotiation_status"
    t.integer "commission"
    t.integer "tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "partner_id"
    t.integer "real_estate_id"
    t.integer "negotiate_real_estate_id"
    t.integer "order_date"
    t.integer "moving_schedule_date"
    t.integer "payment_method"
    t.integer "commission"
    t.integer "order_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "real_estate_comments", force: :cascade do |t|
    t.integer "real_estate_id", null: false
    t.integer "customer_id", null: false
    t.float "rate", default: 0.0, null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "real_estates", force: :cascade do |t|
    t.integer "category_id"
    t.integer "customer_id"
    t.integer "area_id"
    t.string "real_estate_image_id"
    t.string "image_id"
    t.integer "order_id"
    t.string "detail"
    t.string "real_estate_name"
    t.string "nearest_station"
    t.string "kinds"
    t.string "structure"
    t.string "date_of_construction"
    t.string "floor_building"
    t.string "parking"
    t.string "scheduled_to_move_out"
    t.string "offer_price"
    t.string "comments"
    t.integer "real_estate_status"
    t.integer "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

end
