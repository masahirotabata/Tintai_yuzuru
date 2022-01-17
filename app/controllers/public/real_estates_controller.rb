class Public::RealEstatesController < ApplicationController
    
  def new
    @real_estate = RealEstate.new
    @area = Area.new
  end
  
  def create
    @real_estate = RealEstate.new(real_estate_params)
    @real_estate.customer_id = current_customer.id
      if @real_estate.save
      redirect_to public_customer_path(current_customer)
      else
      render 'new'
      end
  end
    
  def destroy
    @real_estate = RealEstate.find_by(params[:id])
      if @real_estate.destroy
        flash[:notice] = '投稿物件を解除しました'
        redirect_to public_customer_path(current_customer)
      else
      　flash[:notice] = '投稿物件を解除に失敗しました'
      end
  end
  
  def show
#admin側だった記述
    @cart_real_estate = CartRealEstate.new  
    @real_estate = RealEstate.find_by(id: params[:id])
    @customer = @real_estate.customer
  end

  def index
    @real_estates = RealEstate.includes(:favorited_customers).sort {|a,b| b.favorited_customers.size <=> a.favorited_customers.size}
    @customer = current_customer
  end

    
  private
  def real_estate_params
    params.require(:real_estate).permit(:category_id, :customer_id, :area_id, :real_estate_image_id,
    :detail, :real_estate_name, :image, :nearest_station,:kinds, :structure, :date_of_construction, :floor_building,
    :parking, :scheduled_to_move_out, :offer_price, :comments, :real_estate_status)
  end
  
end
