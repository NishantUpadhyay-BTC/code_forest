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

ActiveRecord::Schema.define(version: 20160901073218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.integer  "code"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "repository_id"
    t.index ["repository_id"], name: "index_languages_on_repository_id", using: :btree
  end

  create_table "repositories", force: :cascade do |t|
    t.string   "author_name"
    t.string   "avatar_url"
    t.integer  "repo_id"
    t.string   "name"
    t.string   "description"
    t.boolean  "private"
    t.string   "download_link"
    t.string   "clone_url"
    t.string   "git_url"
    t.string   "ssh_url"
    t.string   "svn_url"
    t.integer  "no_of_stars"
    t.integer  "no_of_watchers"
    t.boolean  "has_wiki"
    t.string   "wiki_url"
    t.date     "repo_created_at"
    t.date     "last_updated_at"
    t.integer  "no_of_downloads"
    t.integer  "no_of_views"
    t.integer  "no_of_bookmarks"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "poc_image_file_name"
    t.string   "poc_image_content_type"
    t.integer  "poc_image_file_size"
    t.datetime "poc_image_updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  add_foreign_key "languages", "repositories"
end
