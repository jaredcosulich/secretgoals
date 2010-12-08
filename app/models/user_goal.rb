class UserGoal < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  has_many :updates
  
end
