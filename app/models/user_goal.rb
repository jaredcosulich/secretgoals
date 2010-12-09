class UserGoal < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  has_many :updates

  scope :for_tag, lambda {|tag|
    where("goal_id in (select goal_id from goal_taggings where tag_id = ?)", tag.id)
  }

  delegate :title, :to => :goal
end
