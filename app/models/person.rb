class Person < ActiveRecord::Base
  has_many :feats
  
  def xp
    feats.sum("xp")
  end
end
