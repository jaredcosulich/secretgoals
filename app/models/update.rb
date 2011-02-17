class Update < ActiveRecord::Base
  belongs_to :user_goal
  has_many :replies

  delegate :user, :to => :user_goal

  default_scope order("updates.created_at desc")
  scope :latest, lambda { |limit, page| full.with_comment.limit(limit).offset(page * limit) }

  scope :full, includes([{:user_goal => {:goal => :tags}}, :replies])
  scope :with_comment, where("updates.comment is not null and updates.comment != ''")

  scope :feeling_good, where("status > 6")
  scope :feeling_ok, where("status BETWEEN 4 AND 6")
  scope :feeling_bad, where("status < 4")

  scope :for_tag, lambda {|tag|
    where("user_goal_id in (select id from user_goals where goal_id in (select goal_id from goal_taggings where tag_id = ?))", tag.id)
  }

  scope :not_mine, lambda {|user_id|
    joins(:user_goal).where("user_goals.user_id != ?", user_id)
  }

  scope :since, lambda {|date|
    where("updates.created_at > ?", date)
  }

  after_create :notify_admin

  def goal
    user_goal.goal
  end

  def status_text
    case
      when status < 4: "Needs Support"
      when status > 6: "Feeling Good"
      else "Hanging In"
    end
  end

  def status_class
    text = case
      when status < 4: "bad"
      when status > 6: "good"
      else "ok"
    end
    "#{text}_status"
  end


  def notify_admin
    AdminMailer.delay.notify("New Secret Goal Update", "An update was created:", :update => self, :user_goal => user_goal, :user => user_goal.user, :goal => user_goal.goal)
  end

  def to_param
    id.to_obfuscated
  end


end
