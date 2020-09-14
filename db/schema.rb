# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_200_913_154_407) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'addresses', force: :cascade do |t|
    t.string 'address_first'
    t.string 'address_second'
    t.string 'city'
    t.string 'state'
    t.string 'zip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_addresses_on_user_id'
  end

  create_table 'friend_requests', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'from'
    t.integer 'status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_friend_requests_on_user_id'
  end

  create_table 'friendships', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'friend_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['friend_id'], name: 'index_friendships_on_friend_id'
    t.index ['user_id'], name: 'index_friendships_on_user_id'
  end

  create_table 'user_books', force: :cascade do |t|
    t.string 'status'
    t.string 'isbn'
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_user_books_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.string 'token'
    t.string 'refresh_token'
    t.datetime 'oauth_expires_at'
    t.string 'provider'
    t.string 'uid'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'addresses', 'users'
  add_foreign_key 'friend_requests', 'users'
  add_foreign_key 'friendships', 'users'
  add_foreign_key 'user_books', 'users'
end
