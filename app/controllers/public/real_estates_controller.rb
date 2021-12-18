class Public::RealEstatesController < ApplicationController
    
  def new
    @real_estate = RealEstate.new
  end
  
  def create
    @real_estate = RealEstate.new(real_estate_params)
  if @real_estate.save
      redirect_to real_estates_path
  else
      render 'new'
  end
  
  end
  
def show
@real_estate = RealEstate.find(params[:id])
@customer = @real_estate.customers
 
end

  def index
  
  @customer = current_customer
  @real_estates = RealEstate.all
  # @categories = Cutegory.all
  
  end

    
    private

  def real_estate_params
    params.require(:real_estates).permit(:category_id,:customer_id,:prefecture_id,:real_estate_image_id,
    :detail,:real_estate_name,:nearest_station,:kinds,:structure,:date_of_construction,:floor_building,
    :parking,:scheduled_to_move_out,:offer_price,:comments,:real_estate_status)
  end
  
end
