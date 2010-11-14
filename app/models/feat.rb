class Feat < ActiveRecord::Base
  belongs_to :person
  belongs_to :activity
  
  scope :completed, :conditions => "completed = 't'"


  def complete
      self.completed = true
      self.xp = self.activity.xp
      save
  end

  def uncomplete
      self.completed = false
      save
  end
  
  def date
    activity.start_time.to_date
  end
end
