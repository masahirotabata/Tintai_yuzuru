class Public::OrderRealEstatesController < ApplicationController

 def index
  customers = Customer.all
  @matchers_customers = current_customer.following && current_customer.followers
  end

  def show
  end
  
  def followings
  
  @followings = Customer.find(params[:customer_id]).following
    
  end
  
  def followers
    
  @followers = Customer.find(params[:customer_id]).followers
  
  end
  
  def matchers
    @matchers = followings & followers
  end
  
end