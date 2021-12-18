class Public::OrderRealEstatesController < ApplicationController

  def show
  @order_real_estate = RealEstate.find(params[:real_estate_id])
  end
  
  def index
  @matching_customers = Customer.all.matchers
  @real_estates = matching_customers.real_estates

end
