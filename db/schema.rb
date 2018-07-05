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

ActiveRecord::Schema.define(version: 2018_07_05_181845) do

  create_table "addresses", force: :cascade do |t|
    t.string "address", null: false
    t.string "label"
    t.boolean "is_user", default: false
    t.integer "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_addresses_on_creator_id"
  end

  create_table "coins", force: :cascade do |t|
    t.string "name"
    t.string "ticker"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holdings", force: :cascade do |t|
    t.decimal "quantity"
    t.integer "portfolio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coin_id"
    t.index ["coin_id"], name: "index_holdings_on_coin_id"
    t.index ["portfolio_id"], name: "index_holdings_on_portfolio_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "prices", force: :cascade do |t|
    t.decimal "price"
    t.datetime "timestamp"
    t.integer "coin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_prices_on_coin_id"
  end

  create_table "trades", force: :cascade do |t|
    t.decimal "sell_quantity", null: false
    t.integer "sell_coin_id", null: false
    t.decimal "buy_quantity", null: false
    t.integer "buy_coin_id", null: false
    t.integer "user_id", null: false
    t.string "exchange", null: false
    t.datetime "timestamp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buy_coin_id"], name: "index_trades_on_buy_coin_id"
    t.index ["sell_coin_id"], name: "index_trades_on_sell_coin_id"
    t.index ["user_id"], name: "index_trades_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.decimal "quantity", null: false
    t.datetime "timestamp", null: false
    t.integer "coin_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "to_address_id", null: false
    t.integer "from_address_id", null: false
    t.index ["coin_id"], name: "index_transfers_on_coin_id"
    t.index ["from_address_id"], name: "index_transfers_on_from_address_id"
    t.index ["to_address_id"], name: "index_transfers_on_to_address_id"
    t.index ["user_id"], name: "index_transfers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "auth_token"
    t.datetime "token_created_at"
    t.index ["auth_token", "token_created_at"], name: "index_users_on_auth_token_and_token_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
