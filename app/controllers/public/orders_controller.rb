class Public::OrdersController < ApplicationController
    
    def new
     @order = Order.new
     # cart_real_estates = CartRealEstate.where(customer_id: current_customer.id)
     # @real_estate = cart_real_estate.real_estate_id
     # @customer = current_customer
   end

   def create
     @cart_real_estates = current_customer.cart_real_estates
     @order = current_customer.orders.new(order_params)
     if @order.save
       @cart_real_estates.each do |cart_real_estate|
         order_real_estate = OrderRealEstate.new
         order_real_estate.real_estate_id = cart_real_estate.real_estate_id
         order_real_estate.order_id = @order.id
         order_real_estate.commision = cart_real_estate.real_estate.commision   #右辺上下逆
         order_real_estate.save
       end
       
       redirect_to orders_complete_orders_path
       @cart_real_estates.destroy_all
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
    @cart_real_estates = current_customer.cart_real_estates

    
     
     # if params[:order] == "0"
      
     # redirect_to confirm_public_orders_path
        
    #  elsif params[:order][:to_address] == "1" #お届けの方法が登録している住所の時
    #     @delivery = Delivery.find(params[:order][:delivery_id])
    #     @order.shipping_postal_code = @delivery.delivery_postal_code
    #     @order.delivery_address = @delivery.delivery_address
    #     @order.receiver_name = @delivery.address_name
    #  elsif  params[:order][:to_address] == "2" #新しいお届け先
    #     @address_new = current_customer.deliveries.new
    #     @address_new.customer_id = current_customer.id
    #     @address_new.delivery_postal_code = @order.shipping_postal_code
    #     @address_new.delivery_address = @order.delivery_address
    #     @address_new.address_name = @order.receiver_name
    #     if @address_new.save(order_params)
     # else
     # redirect_to new_public_order_path
    # @cart_real_estates = current_customer.cart_real_estates.all
     # end
    end

   def complete
   end

  private

  def order_params
  params.require(:order).permit(:customer_id, :real_estate_id, :negotiate_id, :order_date, :moving_schedule_date, :partner_name, :payment_method, :commission, :order_status)
  end
  
end
