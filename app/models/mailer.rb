class Mailer < ActionMailer::Base

  helper ApplicationHelper

  ADMIN_EMAILS = ["jared@secretgoals.com"]
  default_url_options[:host] = Rails.application.host
  default :from => "Secret Goals <support@secretgoals.com>", :host => Rails.application.host, :headers => {'X-SMTPAPI' => '{"category": "SecretGoals"}'}#, :bcc => "emails@secretgoals.com"

  def update_reminder(user_id, emailing, user_goal_id)
    @user = User.find(user_id)
    @user_goal = UserGoal.find(user_goal_id)
    @goal = @user_goal.goal
    @emailing = emailing
    mail(
      :to => nice_email_address_for_user(@user),
      :subject => "Reminder: It's been more than #{@user_goal.notification_delay_text} since your last update"
    )
  end

  def notify_new_reply(user_id, emailing, reply_id)
    @user = User.find(user_id)
    @emailing = emailing
    @reply = Reply.find(reply_id, :include => :update)
    mail(
      :to => nice_email_address_for_user(@user),
      :subject => "Someone has #{@reply.action_text}"
    )
  end

  def nice_email_address_for_user(user)
    nice_email_address(user.email, "secret person")
  end

  def nice_email_address(email, name)
    "#{"#{name}" unless name.blank?} <#{email}>"
  end

end
