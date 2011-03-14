class CreateWikiVersionTable < ActiveRecord::Migration
  def self.up
    create_table "wiki_versions", :force => true do |t|
        t.integer  "wiki_id"
        t.integer  "version"
        t.string   "paadal"
        t.string   "paadal_english"
        t.string   "english_short_desc"
        t.string   "tamil_short_desc"
        t.text     "tamil_long_desc"
        t.string   "state"
        t.datetime "created_at"
        t.datetime "updated_at"
      end

      add_index "wiki_versions", ["wiki_id"], :name => "index_wiki_versions_on_wiki_id"

  end

  def self.down
    drop_table :wiki_versions
  end
end
