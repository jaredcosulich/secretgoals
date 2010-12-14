class Tag < ActiveRecord::Base
  include Permalinkable

  has_many :goal_taggings
  has_many :goals, :through => :goal_taggings

  def updates
    Update.for_tag(self)
  end

  def user_goals
    UserGoal.for_tag(self)
  end
end
