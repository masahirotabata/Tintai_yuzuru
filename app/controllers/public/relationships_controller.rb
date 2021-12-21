class Public::RelationshipsController < ApplicationController
    
    before_action :set_customer
    
  def followings
  
  @followings = Customer.find(params[:customer_id]).following
    
  end
  
  def followers
    
  @followers = Customer.find(params[:customer_id]).followers
  
  end
  
  def matchers
    @matchers = current_customer.matching
  end

  def create
    following = current_customer.follow(set_customer)
    if following.save!
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to admin_customer_path(@customer)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
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

  private
  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end