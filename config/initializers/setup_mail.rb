ActionMailer::Base.smtp_settings = {
  :address              => ENV['SQUIRREL_SMTP_HOST'],      # GMAIL would be:smtp.gmail.com, Postfix: localhost
  :port                 => ENV['SQUIRREL_SMTP_PORT'].to_i, # GMAIL would be:587, Postfix: 25
  :domain               => ENV['SQUIRREL_DOMAIN'],         # storeitsquirrel.com
  :user_name            => ENV['SQUIRREL_MAIL_USER'],
  :password             => ENV['SQUIRREL_MAIL_PASSWORD'],
  :authentication       => "plain",
  :enable_starttls_auto => true,
  :openssl_verify_mode  => 'none'
}

#For creation url in email body:
ActionMailer::Base.default_url_options[:host] = ENV['SQUIRREL_MAIL_URL'] # www.storeitsquirrel.com

#For intercepting at development
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
