desc 'send newsletter email'
task send_newsletter_email: :development do
  UserMailer.newsletter.deliver_now
end
