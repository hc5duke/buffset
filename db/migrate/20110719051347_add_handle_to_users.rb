class AddHandleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :handle, :string
  end

  def self.down
    remove_column :users, :handle
  end
end
