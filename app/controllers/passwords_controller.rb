class PasswordsController < Devise::PasswordsController
  include Spree::Core::ControllerHelpers
  helper Spree::BaseHelper
  helper Spree::StoreHelper
end
