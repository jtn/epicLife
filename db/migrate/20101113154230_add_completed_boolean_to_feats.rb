class AddCompletedBooleanToFeats < ActiveRecord::Migration
  def self.up
    add_column :feats, :completed, :boolean, :default => false
  end

  def self.down
    remove_column :feats, :completed
  end
end
