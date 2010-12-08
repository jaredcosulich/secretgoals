class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :updates
  
  has_many :goal_tags
  has_many :tags, :through => :goal_tags    
end
