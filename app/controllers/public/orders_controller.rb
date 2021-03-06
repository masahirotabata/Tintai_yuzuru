class Public::OrdersController < ApplicationController

 def new
  @order = Order.new
  # cart_real_estates = CartRealEstate.where(customer_id: current_customer.id) 
  # @real_estate = cart_real_estate.real_estate_id
  # @customer = current_customer
 end
 def index
  @orders = Order.where(partner_id: current_customer)
 end

 def create
 @cart_real_estate = CartRealEstate.find(params[:id])
 @order = current_customer.orders.new(order_params)
 @order.real_estate_id = @cart_real_estate.real_estate_id
 pp @cart_real_estate, @order
  if @order.save!
  # @cart_real_estates.each do |cart_real_estate|
  order_real_estate = OrderRealEstate.new
  order_real_estate.real_estate_id = @cart_real_estate.real_estate_id
  order_real_estate.order_id = @order.id
  # order_real_estate.commision = cart_real_estate.real_estate.commission   #右辺上下逆
  # end
  redirect_to public_orders_confirm_path(order_id: @order.id)
  else
  @order = Order.new(order_params)
  render :new
  end
 end
 # def index
 #   @orders = current_customer.orders.page(params[:page]).reverse_order.per(10)
 # end
 # def show
 #   @order = Order.find(params[:id])
 #   @ordered_real_estates = @order.order_real_estates
 #   @order.shipping_fee = 800
 # end

 def confirm
 # @cart_real_estate = Order.find_by(customer_id: current_customer.id, order_status: nil)
  @cart_real_estate = Order.find(params[:order_id])
  pp @cart_real_estate

  # @real_estate = RealEstate(current_customer.cart_real_estates.real_estate_id)
  #@cart_real_estate.real_estate.real_estate_name
  # else
  #  # redirect_to new_public_order_path
  # # @cart_real_estates = current_customer.cart_real_estates.all
  #  # end
  # redirect_to confirm_public_orders_path
  # end
 end

  def complete
    if !Order.find(params[:id]).nil?
      @order = Order.find(params[:id])
      # @orders = Order.where(customer_id: current_customer.id, order_status: "done")
      @order.order_status = "done"
      @order.save
      @cart_real_estates = CartRealEstate.find_by(customer_id: current_customer.id, real_estate_id: @order.real_estate_id)
      @cart_real_estates.destroy
    end
  end
 
  private
  def order_params
    params.require(:order).permit(:customer_id, :partner_id, :real_estate_id, :negotiate_id, :order_date, :moving_schedule_date, :payment_method, :commission, :order_status)
  end
end
