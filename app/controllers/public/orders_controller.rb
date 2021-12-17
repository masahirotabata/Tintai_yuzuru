class Public::OrdersController < ApplicationController
    
    def index
    if current_customer.matchers
    @customers = current_customer.matchers
    else
    @customers
    end
   end
  
  
  
  def matchers
  follower_ids = passive_relationships.pluck(:follower_id)
  active_relationships.eager_load(:following)
  .select{|r|follower_ids.include? r.following_id}
  .map{|r|r.following}
 end
  
end
