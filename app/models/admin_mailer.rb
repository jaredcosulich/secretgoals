class AdminMailer < ActionMailer::Base

  default :from => "Secret Goals <support@secretgoals.com>", :host => Rails.application.host

  def notify(subject, message, extra = {})
    mail(
      :to => Mailer::ADMIN_EMAILS,
      :subject => subject,
      :body => message + "\n\n\n" + extra.inspect
    )
  end
end
