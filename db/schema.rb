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

ActiveRecord::Schema.define(:version => 20150317221044) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "games", :force => true do |t|
    t.string   "name"
    t.integer  "genre_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jobs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.string   "status",     :default => ""
    t.float    "price",      :default => 0.0
    t.string   "term",       :default => ""
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "offers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.string   "status",       :default => ""
    t.float    "client_price", :default => 0.0
    t.float    "worker_price", :default => 0.0
    t.text     "comment",      :default => ""
    t.integer  "client_times", :default => 0
    t.integer  "worker_times", :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "play_methods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "play_methods_tasks", :id => false, :force => true do |t|
    t.integer "play_method_id"
    t.integer "task_id"
  end

  create_table "quest_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "from"
    t.integer  "user_id"
    t.boolean  "positive"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "settings", :force => true do |t|
    t.string   "key"
    t.text     "value"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tasks", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",            :default => ""
    t.text     "description",     :default => ""
    t.float    "estimated_price", :default => 0.0
    t.string   "term",            :default => ""
    t.boolean  "active",          :default => true
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "game_id"
    t.integer  "quest_type_id"
    t.string   "status",          :default => "created"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                :default => "",    :null => false
    t.string   "encrypted_password",                                   :default => "",    :null => false
    t.string   "username",                                             :default => ""
    t.string   "first_name",                                           :default => ""
    t.string   "last_name",                                            :default => ""
    t.string   "street",                                               :default => ""
    t.string   "post_index",                                           :default => ""
    t.string   "town",                                                 :default => ""
    t.string   "country",                                              :default => ""
    t.string   "phone",                                                :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                        :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.string   "unconfirmed_email",                                    :default => ""
    t.boolean  "is_admin",                                             :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "approved",                                             :default => true
    t.decimal  "balance",                :precision => 8, :scale => 2, :default => 0.0
    t.integer  "rating",                                               :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
