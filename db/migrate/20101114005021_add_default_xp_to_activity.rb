class AddDefaultXpToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :xp, :integer
  end

  def self.down
    remove_column :activities, :xp
  end
end
