class Feat < ActiveRecord::Base
  belongs_to :person
  belongs_to :activity
  
  named_scope :completed, :conditions => "completed = 't'"


  def complete
      self.completed = true
      save
  end

  def uncomplete
      self.completed = false
      save
  end
end
