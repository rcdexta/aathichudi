class AddAdditionalInfoForUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :photo, :string
    add_column :users, :accepted_count, :integer, :default => 0
    add_column :users, :rejected_count, :integer, :default => 0
  end

  def self.down
    remove_column :users, :name, :photo, :accepted_count, :rejected_count
  end
end
