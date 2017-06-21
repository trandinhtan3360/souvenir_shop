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

ActiveRecord::Schema.define(version: 20170619041116) do

  create_table "bubbles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categori", primary_key: "id_categories", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 128
    t.integer "sort_order", limit: 1
  end

  create_table "categori_product", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "id_product"
    t.integer "id_categories"
    t.index ["id_categories"], name: "id_categories"
    t.index ["id_product"], name: "id_product"
  end

  create_table "comment", primary_key: "id_comment", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "id_user"
    t.integer "id_product"
    t.text "content"
    t.date "created_at"
    t.date "updated_at"
    t.index ["id_product"], name: "id_product"
    t.index ["id_user"], name: "id_user"
  end

  create_table "order_detail", primary_key: "id_detail", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "id_product"
    t.integer "id_orders"
    t.string "quantity", limit: 50
    t.integer "price"
    t.string "created_at", limit: 50
    t.string "updated_at", limit: 50
    t.index ["id_orders"], name: "id_orders"
    t.index ["id_product"], name: "id_product"
  end

  create_table "orders", primary_key: "id_orders", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "full_name", limit: 50
    t.string "address", limit: 250
    t.string "phone", limit: 250
    t.string "created_at", limit: 50
    t.string "updated_at", limit: 50
    t.integer "id_user"
    t.index ["id_user"], name: "id_user"
  end

  create_table "payment_method", primary_key: "payment_id", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "payment_name", limit: 50
    t.string "config", limit: 250
    t.string "description", limit: 250
    t.string "payment", limit: 32
    t.text "payment_info"
    t.string "security", limit: 16
    t.string "message"
  end

  create_table "product", primary_key: "id_product", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "categories_id"
    t.string "name", limit: 100
    t.decimal "price", precision: 15, scale: 4
    t.text "content"
    t.integer "discount", null: false
    t.string "image_link", limit: 50
    t.text "image_list"
    t.integer "view"
  end

  create_table "transaction", primary_key: "id_transaction", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "status", limit: 50
    t.string "amount", limit: 50
    t.integer "id_orders"
    t.integer "payment_id"
    t.index ["id_orders"], name: "id_orders"
    t.index ["payment_id"], name: "payment_id"
  end

  create_table "user", primary_key: "id_user", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "username", limit: 32
    t.string "password", limit: 32
    t.string "name", limit: 50
    t.string "email", limit: 50
    t.string "phone", limit: 15
    t.string "address", limit: 128
    t.integer "role"
    t.string "password_digest", limit: 50
    t.string "remember_digest", limit: 50
    t.string "created_at", limit: 50
    t.string "updated_at", limit: 50
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_foreign_key "categori_product", "categori", column: "id_categories", primary_key: "id_categories", name: "categori_product_ibfk_2"
  add_foreign_key "categori_product", "product", column: "id_product", primary_key: "id_product", name: "categori_product_ibfk_1"
  add_foreign_key "comment", "product", column: "id_product", primary_key: "id_product", name: "comment_ibfk_1"
  add_foreign_key "comment", "user", column: "id_user", primary_key: "id_user", name: "comment_ibfk_2"
  add_foreign_key "order_detail", "orders", column: "id_orders", primary_key: "id_orders", name: "order_detail_ibfk_2"
  add_foreign_key "order_detail", "product", column: "id_product", primary_key: "id_product", name: "order_detail_ibfk_1"
  add_foreign_key "orders", "user", column: "id_user", primary_key: "id_user", name: "orders_ibfk_1"
  add_foreign_key "transaction", "orders", column: "id_orders", primary_key: "id_orders", name: "transaction_ibfk_2"
  add_foreign_key "transaction", "payment_method", column: "payment_id", primary_key: "payment_id", name: "transaction_ibfk_1"
end
