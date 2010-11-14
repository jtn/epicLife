class CreateActivityTypes < ActiveRecord::Migration
  def self.up
    create_table :activity_types do |t|
      t.string :name
      t.float :weight
      t.integer :period
      t.integer :xp

      t.timestamps
    end
  end

  def self.down
    drop_table :activity_types
  end
end
