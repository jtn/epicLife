class Person < ActiveRecord::Base
  has_many :feats
  
  def xp
    feats.completed.sum("xp")
  end
end
