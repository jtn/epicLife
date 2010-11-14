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
  
  def activity_type
    activity.activity_type
  end
  
  def calculate_streak
    streak = filter_streak_candidates_based_on_period(get_streak_candidates, activity_type.period)
    streak.length
  end
  
  private
  
  # candidates are: all completed feats by the same person of same activity type
  def get_streak_candidates
    streak_candidates = person.feats.completed
    streak_candidates = streak_candidates.includes(:activity)
    streak_candidates = streak_candidates.where(["activities.activity_type_id = ?",activity_type.id])
  end
  
  # return candidates which are within the streak period of each other, working our way backwards in time
  def filter_streak_candidates_based_on_period(streak_candidates, period)
    streak_candidates = streak_candidates.order("activities.start_time DESC")
    streak = []
    start_time = streak_candidates.first.date

    streak_candidates.each do |streak_candidate| 
      if ((start_time - period)..(start_time)).include? streak_candidate.date
        streak << streak_candidate
        start_time = streak_candidate.date
      else
        break
      end
    end
    
    streak
  end

end
