# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150920221226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "causes", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.string   "description"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "number_of_contributors"
    t.integer  "goal"
    t.integer  "current_total"
    t.string   "profile_image_url"
    t.datetime "end_date"
  end

  create_table "contributions", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "stripe_transaction_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "cause_id"
  end

  add_index "contributions", ["cause_id"], name: "index_contributions_on_cause_id", using: :btree
  add_index "contributions", ["user_id"], name: "index_contributions_on_user_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "cause_id"
    t.integer  "user_id"
    t.string   "cause_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "conversations", ["cause_id"], name: "index_conversations_on_cause_id", using: :btree
  add_index "conversations", ["user_id"], name: "index_conversations_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.string   "message_body"
    t.string   "image_url"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "cause_id"
    t.boolean  "from_user"
  end

  add_index "messages", ["cause_id"], name: "index_messages_on_cause_id", using: :btree
  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "user_cause_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cause_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "amount_contributed"
    t.date     "last_contribution_date"
    t.boolean  "has_contributed",        default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "authentication_token"
    t.string   "salt"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "facebook_id",                      limit: 8
    t.integer  "current_cause_id"
    t.string   "current_cause_name"
    t.datetime "current_cause_join_date"
    t.string   "encrypted_plaid_token"
    t.integer  "total_amount_contributed"
    t.integer  "current_cause_amount_contributed"
    t.date     "last_contribution_date"
    t.integer  "amount_saved_today"
    t.string   "stripe_customer_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id", using: :btree

end
