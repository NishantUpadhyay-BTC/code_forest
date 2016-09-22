require 'sidekiq'
include Sidekiq::Worker
desc 'send newsletter email'

task send_newsletter_email: :environment do
  NewsletterJob.perform_later
end
