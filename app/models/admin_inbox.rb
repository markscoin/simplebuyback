class AdminInbox < ActiveRecord::Base
  def self.process(email)
    new(email).process
  end

  def initialize(email)
    @email = email
  end

  def process
    create_email
  end

  user_params

  private

  def create_email
    EmailProcessor.create(email: email.from, body: sanitized_body)
  end

  def sanitized_body
    Sanitize.clean(email.body, Sanitize::Config::BASIC)
  end




end
