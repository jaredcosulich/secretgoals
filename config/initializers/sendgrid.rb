Secretgoals::Application.config.action_mailer.smtp_settings= {
  :address => "smtp.sendgrid.net",
  :port => '25',
  :domain => Rails.application.host,
  :authentication => :plain,
  :user_name => "services@irrationaldesign.com",
  :password => "sam7panda"
}
