class Tag < ActiveRecord::Base
  include Permalinkable

  has_many :goal_taggings
  has_many :goals, :through => :goal_taggings

  scope :in_use, where("id in (select distinct tag_id from goal_taggings where goal_id in (select distinct goal_id from user_goals))")

  def updates
    Update.for_tag(self)
  end

  def user_goals
    UserGoal.for_tag(self)
  end
end
