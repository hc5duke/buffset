class AddSeasonToPushupHistories < ActiveRecord::Migration
  def self.up
    add_column :pushup_histories, :season, :integer
    remove_column :users, :active
    add_column :users, :active, :boolean, :default => false
  end

  def self.down
    remove_column :pushup_histories, :season
  end
end
