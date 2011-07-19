class CreatePushupHistories < ActiveRecord::Migration
  def self.up
    create_table :pushup_histories do |t|
      t.references :user
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :pushup_histories
  end
end
