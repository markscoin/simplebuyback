# Preview all emails at http://localhost:3000/rails/mailers/notifier
class NotifierPreview < ActionMailer::Preview
    def welcome_email
      Notifier.welcome_email(User.first)
    end

  def reset_password_instructions
    Notifier.reset_password_instructions(User.first)
  end

end
