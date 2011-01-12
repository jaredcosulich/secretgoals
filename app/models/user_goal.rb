class UserGoal < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  has_many :updates

  scope :for_tag, lambda {|tag|
    where("goal_id in (select goal_id from goal_taggings where tag_id = ?)", tag.id)
  }

  delegate :title, :to => :goal

  after_create :notify_admin

  def to_param
    "#{id.to_obfuscated}-#{goal.permalink}"
  end

  def notify_admin
    AdminMailer.delay.notify("New Secret Goal User Goal", "A user goal was created:", :user => user, :user_goal => self, :goal => goal)
  end

  def self.notification_delay_options
    [["1 day", 1], ["3 days", 3], ["1 week", 7], ["2 weeks", 14], ["1 month", 31], ["never", nil]]
  end

  def notification_delay_text
    UserGoal.notification_delay_options.detect { |option| option.last == notification_delay }.first
  end
end
