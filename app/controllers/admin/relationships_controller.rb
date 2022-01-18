
  
class Admin::RelationshipsController < ApplicationController
    
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
    
    
  end

  def destroy
    following = current_customer.unfollow(@customer)
    if following
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to admin_customer_path(@customer)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to admin_customer_path(@customer)
    end
  end

  def destroy
    following = current_customer.unfollow(set_customer)
    if following
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to admin_customer_path(@customer)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to admin_customer_path(@customer)
    end
  end
end