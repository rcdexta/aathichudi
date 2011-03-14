class CreateWikis < ActiveRecord::Migration
  def self.up
    create_table :wikis do |t|
      t.string :paadal
      t.string :paadal_english
      t.string :english_short_desc
      t.string :tamil_short_desc
      t.text :tamil_long_desc
      t.string :state
      t.integer :version

      t.timestamps
    end
  end

  def self.down
    drop_table :wikis
  end
end
