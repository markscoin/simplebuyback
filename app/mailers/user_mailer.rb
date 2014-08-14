class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url = 'http://www.simpletronix.com/user/sign_up'
    mail(to: @user.email, subject: 'Welcome to Simple Tronix')
  end
end
