class HomeController < ApplicationController
  include Spree::Core::ControllerHelpers
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

  def order
    @user = User.find_by(params[:user_id])
    params[:q] ||= {}
    @search = Spree::Order.ransack(params[:q].merge(user_id_eq: @user.id))
    @orders = @search.result
    render 'home/order'

  end

end
