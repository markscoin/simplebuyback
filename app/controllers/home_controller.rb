class HomeController < ApplicationController

  include Spree::Core::ControllerHelpers::Order
  include Spree::Core::ControllerHelpers::Auth
  helper Spree::BaseHelper
  helper Spree::StoreHelper

  def index
  end

  def show

  end

  def random
    render 'home/random'
  end

  def contact
    render 'home/contact', layout: "contactlayout"
  end

  def send_mail
    name = params[:name]
    email = params[:email]
    subject = params[:subject]
    message = params[:message]
    Notifier.contact_email(name, email, subject, message).deliver
    redirect_to home_contact_path, notice: 'Message Sent. We get back to you ASAP!'
  end

end
