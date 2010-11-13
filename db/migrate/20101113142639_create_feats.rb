class CreateFeats < ActiveRecord::Migration
  def self.up
    create_table :feats do |t|
      t.integer :person_id
      t.integer :activity_id
      t.integer :xp

      t.timestamps
    end
  end

  def self.down
    drop_table :feats
  end
end
