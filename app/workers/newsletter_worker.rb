class NewsletterWorker
  include Sidekiq::Worker
  def perform
    @newsletter_pocs = NewsletterData.new.call
    @recipients = User.subscribed_users
    @recipients.each do |r|
      UserMailer.newsletter(r.email, @newsletter_pocs).deliver_now
    end
  end
end
