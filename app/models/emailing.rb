class Emailing < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :links, :as => "source"

  serialize :params

  def name
    "Email: #{email_name}"
  end

  def auto_login_url(path)
    link = links.create(:path => path)
    user.ensure_authentication_token!
    link_url(:link => link.to_param, :token => user.authentication_token, :host => Rails.application.host)
  end

  def self.deliver(email_name, user_id, *params)
    emailing = Emailing.create(:user_id => user_id, :email_name => email_name, :params => params)
    email = Mailer.send(email_name, user_id, emailing, *params).deliver
    emailing.update_attribute(:body, email.body)
  end

  def redeliver
    Mailer.send(email_name, user_id, self, *params).deliver
    touch
  end
end
