class Update < ActiveRecord::Base
  belongs_to :user_goal

  default_scope order("updates.created_at desc")
  scope :latest, lambda { |limit| full.limit(limit) }

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

  def status_text
    text = case
      when status < 4: "could use some support"
      when status > 6: "is feeling good"
      else "is hanging in there"
     end
    "Someone #{text} (#{status})"
  end

end
