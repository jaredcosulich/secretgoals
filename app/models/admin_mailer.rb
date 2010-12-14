class AdminMailer < ActionMailer::Base

  default :from => "Secret Goals <support@secretgoals.com>", :host => Rails.application.host

  def notify(subject, message, extra = {})
    body = "#{message}\n\n\n#{extra.inject(""){|report, entry| report << "\n\n#{entry.first}\n#{PP.pp(entry.last.as_json, "", 40)}" }}"
    mail(
      :to => Mailer::ADMIN_EMAILS,
      :subject => subject,
      :body => body
    )
  end
end
