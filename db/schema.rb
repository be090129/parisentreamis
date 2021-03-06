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

ActiveRecord::Schema.define(version: 20160312200516) do

  create_table "bets", force: true do |t|
    t.datetime "start_at"
    t.integer  "score1"
    t.integer  "score2"
    t.integer  "equipe1_id"
    t.integer  "equipe2_id"
    t.integer  "global_result_point"
    t.integer  "result_point"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
    t.boolean  "not_refresh"
  end

  add_index "bets", ["tournament_id"], name: "index_bets_on_tournament_id"

  create_table "ligues", force: true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
  end

  add_index "ligues", ["tournament_id"], name: "index_ligues_on_tournament_id"

  create_table "members", force: true do |t|
    t.integer  "user_id"
    t.integer  "ligue_id"
    t.string   "status"
    t.integer  "score"
    t.integer  "scoreday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pwin"
    t.integer  "ploose"
  end

  add_index "members", ["ligue_id"], name: "index_members_on_ligue_id"
  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "players", force: true do |t|
    t.string   "name"
    t.string   "post"
    t.integer  "point"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
  end

  add_index "players", ["team_id"], name: "index_players_on_team_id"

  create_table "pronostics", force: true do |t|
    t.integer  "user_id"
    t.integer  "bet_id"
    t.integer  "ligue_id"
    t.integer  "score1"
    t.integer  "score2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "teams", ["tournament_id"], name: "index_teams_on_tournament_id"

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.boolean  "is_admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
