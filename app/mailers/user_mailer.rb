class UserMailer < ApplicationMailer
 default from: 'codeforestdemo@gmail.com'
  def newsletter
    @recipients = User.subscribed_users
    @recipients.each do |r|
      mail(:to => r.email,
        :subject => "Newsletter")
     end
 end
end
