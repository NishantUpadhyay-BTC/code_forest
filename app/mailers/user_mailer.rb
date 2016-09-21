class UserMailer < ApplicationMailer
  default from: 'codeforestdemo@gmail.com'
  def newsletter(email, newsletter_pocs)
    @newsletter_pocs = newsletter_pocs
    mail(to: email, subject: "Newsletter")
  end
end
