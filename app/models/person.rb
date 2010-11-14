# encoding: UTF-8
class Person < ActiveRecord::Base
  has_many :feats

  @@level_constant = 700.0

  def xp
    feats.completed.sum("xp")
  end

  def levelFunctionXp(level)
    (1/@@level_constant*level).floor
  end

  def level
    #((self.xp - 1)/@@level_constant).floor;
    levelFunctionXp(self.xp)
  end

  def level_at_xp
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
