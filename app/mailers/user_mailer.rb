class UserMailer < ApplicationMailer
 default from: 'naiya.d.shah@gmail.com'
  def newsletter
    # @recipients = User.subscribed_users
    # @url  = root_url
    # @recipients.each do |r|
    #   @name = r.name
      mail(:to => 'manojparmar5606@gmail.com',
        :subject => "Newsletter")
    #  end
 end
end
