class Public::FavoritesController < ApplicationController
  def create
    @real_estate = RealEstate.find(params[:real_estate_id])
    favorite = @real_estate.favorites.new(customer_id: current_customer.id)
    favorite.save
    flash[:success] = "Liked post"
    redirect_to request.referer
    
 end

  def destroy
    @real_estate = RealEstate.find(params[:real_estate_id])
    favorite = current_customer.favorites.find_by(real_estate_id: @real_estate.id)
    favorite.destroy
    redirect_to request.referer
  end
end

