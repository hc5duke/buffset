class AddPushupSetCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :pushup_set_count, :integer, :default => 0
  end

  def self.down
    remove_column :users, :pushup_set_count
  end
end
