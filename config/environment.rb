# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Provide better details into the environment
ActiveRecord::Base.logger.level = Logger::DEBUG