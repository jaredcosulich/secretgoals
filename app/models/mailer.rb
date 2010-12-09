class Mailer < ActionMailer::Base

  helper ApplicationHelper

  ADMIN_EMAILS = ["adam@secretgoals.com", "jared@secretgoals.com"]
  default :from => "Secret Goals <support@secretgoals.com>", :bcc => "emails@secretgoals.com", :host => Rails.application.host

end
