class AddMultiplierToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :multiplier, :integer, :default => 20, :nil => false
    add_column :pushup_histories, :multiplier, :integer, :default => 20, :nil => false
  end

  def self.down
    remove_column :users, :multiplier
    remove_column :pushup_histories, :multiplier
  end
end
