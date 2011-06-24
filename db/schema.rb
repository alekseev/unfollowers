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

ActiveRecord::Schema.define(:version => 20110420184953) do

  create_table "access_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "key"
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["key"], :name => "index_access_tokens_on_key", :unique => true

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "followers", :force => true do |t|
    t.integer  "twitter_id"
    t.integer  "user_id"
    t.integer  "followers"
    t.integer  "following"
    t.integer  "tweets"
    t.string   "name"
    t.string   "screen_name"
    t.string   "image"
    t.string   "description"
    t.boolean  "new",         :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "unfollower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unfollowers", :force => true do |t|
    t.integer  "twitter_id"
    t.integer  "user_id"
    t.integer  "followers"
    t.integer  "following"
    t.integer  "tweets"
    t.string   "name"
    t.string   "screen_name"
    t.string   "image"
    t.string   "description"
    t.boolean  "new",         :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.string   "user_session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sessions", ["updated_at"], :name => "index_user_sessions_on_updated_at"
  add_index "user_sessions", ["user_session_id"], :name => "index_user_sessions_on_user_session_id"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                     :null => false
    t.integer  "login_count",       :default => 0,      :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.boolean  "updating",          :default => false
    t.boolean  "first_time",        :default => true
    t.integer  "updated"
    t.datetime "last_update"
    t.integer  "active_token_id"
    t.integer  "twitter_id"
    t.integer  "followers_count"
    t.string   "name"
    t.string   "mail_period",       :default => "hour"
    t.datetime "mail_sent"
    t.string   "validation_code"
    t.boolean  "email_validated",   :default => false
  end

  add_index "users", ["active_token_id"], :name => "index_users_on_active_token_id"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
