class Admin::RealEstatesController < ApplicationController
    
    
    def index
   
    end
    
    def show
    
   
    end
    
    def create
   
  
    end
    
    private

    def real_estate_params
    params.permit(:category_id, :customer_id, :prefecture_id, :real_estate_image_id,
     :detail, :real_estate_name, :nearest_station,:kinds, :structure,:date_of_construction, :floor_building,
    :parking, :scheduled_to_move_out, :offer_price, :comments, :real_estate_status)
    end
  
end
