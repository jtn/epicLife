class Person < ActiveRecord::Base
  has_many :feats

  def xp
    feats.completed.sum("xp")
  end

  def next_level
    500
  end

  def avatar_url_or_fallback
    avatar_url || "/images/Alfred_E_Neumann_128x128.png"
  end
end
