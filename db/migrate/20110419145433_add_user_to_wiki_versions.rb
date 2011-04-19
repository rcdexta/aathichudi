class AddUserToWikiVersions < ActiveRecord::Migration
  def self.up
    add_column :wiki_versions, :user_id, :integer
    add_index :wiki_versions, :user_id, :name => 'wiki_versions_by_user'
  end

  def self.down
    remove_column :wiki_versions, :user_id
    remove_index :wiki_versions, :name => 'wiki_versions_by_user'
  end
end
