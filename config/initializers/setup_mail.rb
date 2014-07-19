ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => Setting.cached.smtp_server,
  :port                 => Setting.cached.smtp_port,
  :domain               => ((Setting.cached.smtp_username) || '@').split("@")[1],
  :user_name            => Setting.cached.smtp_username,
  :password             => Setting.cached.smtp_password,
  :authentication       => :plain,
  :enable_starttls_auto => Setting.cached.smtp_tls
}

require 'development_mail_interceptor'
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
