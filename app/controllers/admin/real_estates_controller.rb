class Admin::RealEstatesController < ApplicationController
    
    def index
    
   @real_estates = RealEstate.where(customer_id: current_customer)
    # if @customers = customer.followers
     
       
    # # else
    # end
    end
    
    def show
      
    @real_estate = RealEstate.find_by(id: params[:id])
   
    end
    
    def create
   
    @real_estate = RealEstate.new(real_estate_params)
    @real_estate.customer_id = current_customer.id
     
    if @real_estate.save!
      redirect_to admin_customer_path(@real_estate)
    else
      render 'new'
    end
  
    end
    
    private

    def real_estate_params
    params.permit(:category_id, :customer_id, :prefecture_id, :real_estate_image_id,
     :detail, :real_estate_name, :nearest_station,:kinds, :structure,:date_of_construction, :floor_building,
    :parking, :scheduled_to_move_out, :offer_price, :comments, :real_estate_status)
    end
  
end
