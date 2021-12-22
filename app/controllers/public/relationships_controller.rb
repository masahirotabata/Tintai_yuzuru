class Public::RelationshipsController < ApplicationController
    
  def followings
  
  @followings = Customer.find(params[:customer_id]).following
    
  end
  
  def followers
    
  @followers = Customer.find(params[:customer_id]).followers
  
  end
  
  def matchers
    @matchers = followings & followers
  end
  
  def create
    @customer = Customer.find(params[:customer_id])
    following = current_customer.follow(@customer)
    if following.save!
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to public_customer_path(@customer)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to public_customer_path(@customer)
    end
     #通知の作成
     @current_customer.create_notification_follow!(current_user)
    
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    following = current_customer.unfollow(@customer)
    if following
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to public_customer_path(@customer)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to public_customer_path(@customer)
    end
 
  end
end