class Activity < ActiveRecord::Base
  belongs_to :activity_type
  has_many :feats
  
  def xp
    activity_type.xp
  end
end
