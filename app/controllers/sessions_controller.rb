class SessionsController < Devise::SessionsController
  include Spree::Core::ControllerHelpers
  helper Spree::BaseHelper
  helper Spree::StoreHelper

end
