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

ActiveRecord::Schema.define(version: 20171130055703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer "trick_id"
    t.integer "contributor_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contributor_id"], name: "index_comments_on_contributor_id"
    t.index ["trick_id"], name: "index_comments_on_trick_id"
  end

  create_table "contributors", force: :cascade do |t|
    t.string "email"
    t.string "nick_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "contributor_id"
    t.integer "trick_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contributor_id", "trick_id"], name: "index_favorites_on_contributor_id_and_trick_id", unique: true
    t.index ["contributor_id"], name: "index_favorites_on_contributor_id"
    t.index ["trick_id"], name: "index_favorites_on_trick_id"
  end

  create_table "tricks", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "duration"
    t.bigint "contributor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contributor_id", "created_at"], name: "index_tricks_on_contributor_id_and_created_at"
    t.index ["contributor_id"], name: "index_tricks_on_contributor_id"
  end

  add_foreign_key "tricks", "contributors"
end
