require 'sidekiq'
include Sidekiq::Worker

task send_newsletter_email: :environment do
  NewsletterWorker.perform_async
end
