class NonProductionMailInterceptor
  def self.delivering_email(message)
    message.subject = "[#{message.to}] #{message.subject}"
    message.to = "emails@irrationaldesign.com"
    message.bcc = ""
  end
end
