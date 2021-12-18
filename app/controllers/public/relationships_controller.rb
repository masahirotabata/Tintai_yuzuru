class Public::RelationshipsController < ApplicationController
    
     # フォローするとき
  def create
    customer = Customer.find(params[:customer_id])
    customer.follow(params[:customer_id]).save!
    redirect_to request.referer
  end
  
  # フォロー外すとき
  def destroy
    customer = Customer.find(params[:customer_id])
    customer.unfollow(params[:customer_id]).destroy
    redirect_to request.referer  
  end
  # フォロー一覧
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end
  
  # フォロワー一覧
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end
  
end
