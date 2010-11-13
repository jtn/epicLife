class Feat < ActiveRecord::Base
  belongs_to :person
  belongs_to :activity
  
  named_scope :completed, :conditions => "completed = 't'"
end
