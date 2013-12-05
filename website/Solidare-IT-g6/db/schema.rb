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

ActiveRecord::Schema.define(version: 20131205123600) do

  create_table "accept_services", force: true do |t|
    t.integer  "service_id"
    t.integer  "user_id"
    t.boolean  "is_chosen_customer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "addresses", force: true do |t|
    t.string   "street"
    t.integer  "number",      default: 0
    t.integer  "postal_code", default: 0
    t.string   "city"
    t.string   "country"
    t.integer  "user_id",     default: 0
    t.integer  "orga_id",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "principal",   default: false
    t.integer  "latitude",    default: 0
    t.integer  "longitude",   default: 0
  end

  create_table "badges_sashes", force: true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id"
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id"

  create_table "categories", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "parent",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coworkers", force: true do |t|
    t.integer  "organisation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "validated",       default: false
  end

  create_table "followers", force: true do |t|
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_post_comments", force: true do |t|
    t.integer  "group_post_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_post_comments", ["group_post_id"], name: "index_group_post_comments_on_group_post_id"
  add_index "group_post_comments", ["user_id"], name: "index_group_post_comments_on_user_id"

  create_table "group_posts", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_posts", ["group_id"], name: "index_group_posts_on_group_id"
  add_index "group_posts", ["user_id"], name: "index_group_posts_on_user_id"

  create_table "group_user_relations", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "group_user_relations", ["group_id"], name: "index_group_user_relations_on_group_id"
  add_index "group_user_relations", ["user_id"], name: "index_group_user_relations_on_user_id"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private"
    t.boolean  "secret"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "merit_actions", force: true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: true do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: true do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "notifications", force: true do |t|
    t.integer  "notified_user"
    t.string   "notification_type"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "seen"
    t.integer  "creator_id"
    t.integer  "group_id"
  end

  create_table "organisations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.boolean  "validated",  default: false
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "sashes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "date_start"
    t.datetime "date_end"
    t.boolean  "quick_match",         default: false
    t.integer  "matching_service_id", default: 0
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_demand",           default: false
    t.integer  "org_id",              default: 0
    t.integer  "category_id",         default: 1
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "address_id",          default: 0
  end

  create_table "transactions", force: true do |t|
    t.text     "feedback_comments"
    t.integer  "feedback_evaluation"
    t.integer  "service_id",          default: 0
    t.integer  "user_id",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "firstname"
    t.datetime "birthdate"
    t.string   "email"
    t.integer  "karma",                   default: 0
    t.boolean  "id_ok",                   default: false
    t.text     "presentation"
    t.boolean  "inscription_ok",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "language",                default: "en"
    t.integer  "coworker_org_id",         default: 0
    t.integer  "managed_org_id",          default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "mail_notif",              default: false
    t.boolean  "managed_by_organisation", default: false
    t.integer  "coworker_id",             default: 0
    t.integer  "sash_id"
    t.integer  "level",                   default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
