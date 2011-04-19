class RemoveStateAndVersionFromWikis < ActiveRecord::Migration
  def self.up
    remove_column :wikis, :state
    remove_column :wikis, :version
  end

  def self.down
    add_column :wikis, :state, :string
    add_column :wikis, :version, :integer
  end
end
