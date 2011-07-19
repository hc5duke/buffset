class AddActiveToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :active, :boolean
    add_column :users, :admin, :boolean
  end

  def self.down
    remove_column :users, :active
    remove_column :users, :admin
  end
end
