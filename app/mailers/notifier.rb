class Notifier < ActionMailer::Base
  default from: "support@simpletronix.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email,
         :subject => "Welcome to Simple Tronix")
  end

  def contact_email(name, email, subject, message)
    @name = name
    @email = email
    @subject = subject
    @message = message

    mail(from: email, to: "support@simpletronix.com", subject: 'Support Request')
  end

end
