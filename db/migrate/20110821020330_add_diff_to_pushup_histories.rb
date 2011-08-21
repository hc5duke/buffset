class AddDiffToPushupHistories < ActiveRecord::Migration
  def self.up
    add_column :pushup_histories, :diff, :integer, :nil => false
  end

  def self.down
    remove_column :pushup_histories, :diff
  end
end
