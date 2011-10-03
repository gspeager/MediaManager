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

ActiveRecord::Schema.define(:version => 20111002202424) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.string   "year"
    t.string   "public_token"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id"
  end

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "start"
    t.string   "end"
    t.text     "bio"
    t.string   "public_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
  end

  add_index "notices", ["user_id"], :name => "index_notices_on_user_id"

  create_table "songs", :force => true do |t|
    t.string   "title"
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
    t.integer  "album_id"
    t.integer  "artist_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "user_id"
    t.string   "public_token"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "public_token"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "city"
    t.string   "country"
    t.text     "tvshows"
    t.text     "movies"
    t.text     "artists"
    t.text     "albums"
    t.text     "liveshows"
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
