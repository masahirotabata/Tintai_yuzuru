class Public::RealEstatesController < ApplicationController
    
  def new
    @real_estate = RealEstate.new
    @area = Area.new
  end
  
  def create
  #admin側だった記述
    @real_estate = RealEstate.new(real_estate_params)
    @real_estate.customer_id = current_customer.id

     
    if @real_estate.save
      redirect_to public_customer_path(current_customer)
    else
      render 'new'
    end
   
  
  end
  
def show
#admin側だった記述
@real_estate = RealEstate.find_by(id: params[:id])
   
@real_estate = RealEstate.find(params[:id])
@customer = @real_estate.customer
 
end

  def index
  
   #admin側だった記述 
   @real_estates = RealEstate.where(customer_id: current_customer)
    # if @customers = customer.followers
     
       
    # # else
    # end
  
  @customer = current_customer
  @real_estates = RealEstate.all
  # @categories = Cutegory.all
  
  end

    
    private

  def real_estate_params
    params.require(:real_estate).permit(:category_id, :customer_id, :area_id, :real_estate_image_id,
    :detail, :real_estate_name, :image, :nearest_station,:kinds, :structure, :date_of_construction, :floor_building,
    :parking, :scheduled_to_move_out, :offer_price, :comments, :real_estate_status)
  end
  
end
