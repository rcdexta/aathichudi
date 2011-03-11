class CreateWikis < ActiveRecord::Migration
  def self.up
    create_table :wikis do |t|
      t.string :paadal
      t.string :paadal_english
      t.string :english_short_desc
      t.string :tamil_short_desc
      t.text :tamil_long_desc
      t.boolean :head
      t.string :state
      t.integer :version

      t.timestamps
    end
    Wiki.create_versioned_table
  end

  def self.down
    drop_table :wikis
    Wiki.drop_versioned_table
  end
end
