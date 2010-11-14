# encoding: UTF-8
class Person < ActiveRecord::Base
  has_many :feats

  @@level_constant = 700.0

  def xp
    feats.completed.sum("xp")
  end

  def level_function_xp(xp)
    (xp/@@level_constant).floor
  end

  def next_level_ratio
    xp_for_current_level = self.xp_at_level(self.level)
    (self.xp-xp_for_current_level)/(self.xp_for_next - xp_for_current_level)
  end

  def level
    level_function_xp(self.xp)
  end

  def xp_at_level(level)
    level*@@level_constant
  end
  def xp_for_next
       ((level+1)*@@level_constant)
  end


  def avatar_url_or_fallback
    avatar_url || "/images/Alfred_E_Neumann_128x128.png"
  end


  def level_to_string
      month, day = self.level.divmod(30)
      spoken_month = 'månad' 
      spoken_month += 'er' if month != 1 
      spoken_day = 'dag'
      spoken_day += 'ar' if day != 1
      "#{month} #{spoken_month} #{day} #{spoken_day}"
  end

  #This function should calculate feats,
  #the xpGained from the feate at this time.
  #It should se if we have gained a new level.
  def evaluate_feat(feat)
  end

  def calculate_streak(feat)
    streak_candidates = get_streak_candidates(feat)
    streak = filter_streak_candidates_based_on_period(streak_candidates, feat.activity.activity_type.period)
    streak.length
  end
  
  private
  
  # candidates are: all completed feats of same type as feat.
  def get_streak_candidates(feat)
    activity_type = feat.activity.activity_type
    streak_candidates = feats.completed
    streak_candidates = streak_candidates.includes(:activity)
    streak_candidates = streak_candidates.where(["activities.activity_type_id = ?",activity_type.id])
  end
  
  # Check if a candidate is within the streak period. Streak candidates are in descending start_time order.
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
