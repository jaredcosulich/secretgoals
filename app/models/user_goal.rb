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
    id.to_obfuscated
  end

  def notify_admin
    AdminMailer.notify("New Secret Goal User Goal", "A user goal was created:", :user => user, :user_goal => self, :goal => goal).deliver
  end
end
