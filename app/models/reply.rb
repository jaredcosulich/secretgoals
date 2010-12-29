class Reply < ActiveRecord::Base
  belongs_to :update
  belongs_to :commenter, :class_name => "User"

  validates_inclusion_of :reply_type, :in => %w{reply support congratulation}
  validates_presence_of :comment

  after_create :notify_new_reply
  after_create :notify_admin

  default_scope order("replies.created_at asc")


  def action_text
    case reply_type
      when "support": "sent you a message of support"
      when "congratulation": "congratulated you"
      else "replied to your update"
    end
  end

  def notify_new_reply
    Emailing.deliver("notify_new_reply", update.user_goal.user_id, self.id)
  end

  def notify_admin
    AdminMailer.notify("New Secret Goals Reply", "A reply was created:", :reply => reply, :update => update).deliver
  end
end
