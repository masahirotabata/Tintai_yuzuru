class Admin::NegotiatesController < ApplicationController
  def show
    @negotiate_real_estate_new = Relashionship.new
  end
   
  def index
    customers = Customer.all
    if admin_signed_in?
      @following = current_admin.following 
    else
      @following = current_customer.following 
    end
  end
 
  def create
    if  @negotiate_real_estate.save(real_estate_params)
    redirect_to real_estates_path
    else
    render 'new'
    end
  
  end
   
    
  def real_estate_params
  params.require(:real_estate).permit(:category_id,:customer_id,:prefecture_id,:real_estate_image_id,
  :detail,:real_estate_name,:nearest_station,:kinds,:structure,:date_of_construction,:floor_building,
  :parking,:scheduled_to_move_out,:offer_price,:comments,:real_estate_status)
  end
  
end
