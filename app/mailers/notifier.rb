class Notifier < ActionMailer::Base
  default from: "support@simpletronix.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email,
         :subject => "Welcome to Simple Tronix")
  end
end
