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

ActiveRecord::Schema.define(:version => 20110103235737) do

  create_table "admins", :force => true do |t|
    t.string   "email",                              :default => "", :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "", :null => false
    t.string   "password_salt",                      :default => "", :null => false
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true

  create_table "beta_requests", :force => true do |t|
    t.string   "email"
    t.datetime "invited_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  add_index "delayed_jobs", ["locked_by"], :name => "delayed_jobs_locked_by"
  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "emailings", :force => true do |t|
    t.integer  "user_id"
    t.string   "email_name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emailings", ["user_id"], :name => "index_emailings_on_user_id"

  create_table "goal_taggings", :force => true do |t|
    t.integer  "goal_id",    :null => false
    t.integer  "tag_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goal_taggings", ["goal_id", "tag_id"], :name => "index_goal_taggings_on_goal_id_and_tag_id"
  add_index "goal_taggings", ["tag_id", "goal_id"], :name => "index_goal_taggings_on_tag_id_and_goal_id"

  create_table "goals", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goals", ["permalink"], :name => "index_goals_on_permalink", :unique => true

  create_table "link_clicks", :force => true do |t|
    t.integer  "link_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "link_clicks", ["link_id"], :name => "index_link_clicks_on_link_id"

  create_table "links", :force => true do |t|
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["source_type", "source_id"], :name => "index_links_on_source_type_and_source_id"

  create_table "replies", :force => true do |t|
    t.integer  "update_id"
    t.integer  "commenter_id"
    t.string   "reply_type"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "replies", ["commenter_id"], :name => "index_replies_on_commenter_id"
  add_index "replies", ["update_id"], :name => "index_replies_on_update_id"

  create_table "tags", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["permalink"], :name => "index_tags_on_permalink", :unique => true

  create_table "updates", :force => true do |t|
    t.integer  "user_goal_id", :null => false
    t.integer  "status"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "updates", ["created_at"], :name => "index_updates_on_created_at"
  add_index "updates", ["user_goal_id"], :name => "index_updates_on_user_goal_id"

  create_table "user_goals", :force => true do |t|
    t.integer  "goal_id",                      :null => false
    t.integer  "user_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notification_delay"
    t.datetime "last_emailed_update_reminder"
  end

  add_index "user_goals", ["goal_id"], :name => "index_user_goals_on_goal_id"
  add_index "user_goals", ["user_id"], :name => "index_user_goals_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
