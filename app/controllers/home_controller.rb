class HomeController < ApplicationController
  include Spree::Core::ControllerHelpers
  helper Spree::BaseHelper
  helper Spree::StoreHelper

 
  
  def index
    
  end

  def show

  end

  def faq
    render 'home/faq'
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
    redirect_to home_contact_path, notice: "Message Sent. We'll get back to you ASAP!"
  end

  def order
    @user = User.find_by(params[:user_id])
    params[:q] ||= {}
    @search = Spree::Order.ransack(params[:q].merge(user_id_eq: @user.id))
    @orders = @search.result
    render 'home/order'
  end

  def notifications
    @products = Spree::Product.all
    @variants = Spree::Variant.all
    @prices = Spree::Price.all
    @productlist = @products.map { |x| {id: x.id, name: x.name}}
    @variantslist = @variants.map { |y| {variant_id: y.id, condition: y.position, id: y.product_id }}
    @prices = @prices.map {|z| {variant_id: z.variant_id, price: z.amount}}
    @almost = @variantslist.map { |x| x.merge (@productlist.find { |h| h[:id] == x[:id] } || {} ) }
    @complete = @almost.map { |x| x.merge (@prices.find { |h| h[:variant_id] == x[:variant_id] } || {} ) }
    @completesorted = @complete.sort_by { |x| x[:variant_id] }
    @completefinal = @completesorted.delete_if { |x| x[:condition] == 1}
  end
  

end

