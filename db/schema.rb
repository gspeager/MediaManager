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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110920031124) do

  create_table "owners", :force => true do |t|
    t.string   "ownerName"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", :force => true do |t|
    t.string   "filename"
    t.string   "title"
    t.string   "artist"
    t.string   "album"
    t.string   "length"
    t.integer  "tracknumber"
    t.string   "year"
    t.string   "genre"
    t.string   "albumart"
    t.float    "rating"
    t.integer  "playcount"
    t.string   "lastplay"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "filename"
    t.string   "title"
    t.boolean  "isTV"
    t.string   "series"
    t.integer  "episode"
    t.integer  "season"
    t.string   "year"
    t.string   "length"
    t.string   "genre"
    t.float    "rating"
    t.string   "director"
    t.string   "actors"
    t.integer  "playcount"
    t.string   "lastplay"
    t.string   "thumbnail"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user"
  end

end
