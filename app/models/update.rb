class Update < ActiveRecord::Base
  belongs_to :user_goal

  scope :latest, lambda { |limit| full.order("created_at desc").limit(limit) }

  scope :full, includes(:user_goal => {:goal => :tags})

  scope :feeling_good, where("status > 6")
  scope :feeling_ok, where("status BETWEEN 4 AND 6")
  scope :feeling_bad, where("status < 4")

  scope :for_tag, lambda {|tag|
    where("user_goal_id in (select id from user_goals where goal_id in (select goal_id from goal_taggings where tag_id = ?))", tag.id)
  }

  def goal
    user_goal.goal
  end

end
