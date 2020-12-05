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

ActiveRecord::Schema.define(version: 2020_10_30_075211) do

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "campany", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campany"], name: "index_clients_on_campany", unique: true
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_departments_on_name"
  end

  create_table "evaluation_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "comment", null: false
    t.bigint "product_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_evaluation_data_on_product_id"
    t.index ["user_id"], name: "index_evaluation_data_on_user_id"
  end

  create_table "evaluation_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image", null: false
    t.bigint "evaluation_datum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_datum_id"], name: "index_evaluation_images_on_evaluation_datum_id"
  end

  create_table "inspection_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "length", null: false
    t.integer "width", null: false
    t.float "weight", null: false
    t.text "comment", null: false
    t.bigint "product_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_inspection_data_on_product_id"
    t.index ["user_id"], name: "index_inspection_data_on_user_id"
  end

  create_table "inspection_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image", null: false
    t.bigint "inspection_datum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inspection_datum_id"], name: "index_inspection_images_on_inspection_datum_id"
  end

  create_table "materials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.float "basis_weight", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_materials_on_name", unique: true
  end

  create_table "production_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "comment", null: false
    t.bigint "product_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_production_data_on_product_id"
    t.index ["user_id"], name: "index_production_data_on_user_id"
  end

  create_table "production_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image", null: false
    t.bigint "production_datum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["production_datum_id"], name: "index_production_images_on_production_datum_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "number", null: false
    t.float "length", null: false
    t.integer "width", null: false
    t.bigint "client_id"
    t.bigint "material_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_products_on_client_id"
    t.index ["material_id"], name: "index_products_on_material_id"
    t.index ["number"], name: "index_products_on_number", unique: true
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "number", null: false
    t.string "encrypted_password", null: false
    t.bigint "department_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["number"], name: "index_users_on_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "evaluation_data", "products"
  add_foreign_key "evaluation_data", "users"
  add_foreign_key "evaluation_images", "evaluation_data"
  add_foreign_key "inspection_data", "products"
  add_foreign_key "inspection_data", "users"
  add_foreign_key "inspection_images", "inspection_data"
  add_foreign_key "production_data", "products"
  add_foreign_key "production_data", "users"
  add_foreign_key "production_images", "production_data"
  add_foreign_key "products", "clients"
  add_foreign_key "products", "materials"
  add_foreign_key "products", "users"
  add_foreign_key "users", "departments"
end
