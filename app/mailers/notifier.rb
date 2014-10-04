class Notifier < ActionMailer::Base
  default from: "support@simplebuyback.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email,
         :subject => "Welcome to SimpleBuyBack")
  end

  def contact_email(name, email, subject, message)
    @name = name
    @email = email
    @subject = subject
    @message = message
    mail(from: email, to: "support@simplebuyback.com", subject: 'Support Request')
  end

end
