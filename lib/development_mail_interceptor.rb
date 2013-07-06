class DevelopmentMailInterceptor
  def self.delivering_email(message)
     message.subject = "#{message.to} #{message.cc} #{message.bcc} #{message.subject}"
     message.to = "brady.holt@gmail.com"
     message.cc = ""
     message.bcc = ""
  end
end