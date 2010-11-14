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
    #((self.xp - 1)/@@level_constant).floor;
    level_function_xp(self.xp)
  end

  def xp_at_level(level)
    level*@@level_constant
  end
  def xp_for_next
       ((level+1)*700)
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

end
