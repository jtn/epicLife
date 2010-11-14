class ActivityBelongsToActivityType < ActiveRecord::Migration
  def self.up
    add_column :activities, :activity_type_id, :integer
    remove_column :activities, :xp
  end

  def self.down
    remove_column :activities, :activity_type_id
    add_column :activities, :xp, :integer
  end
end
