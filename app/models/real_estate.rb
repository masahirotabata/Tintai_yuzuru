class RealEstate < ApplicationRecord
  belongs_to :category,optional: true
  has_many :favorites
  has_many :notifications
  belongs_to :customer,optional: true
  has_many :orders
	
 def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
 end
    
    
    
 def self.looks(search, word)
    if search == "perfect_match"
      @real_estate = RealEstate.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @real_estate = RealEstate.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @real_estate = RealEstate.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @real_estate = RealEstate.where("title LIKE?","%#{word}%")
    else
      @real_estate = RealEstate.all
    end
 end
    
    
  #いいね機能の実装
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
  
  #通知機能の実装  
  def create_notification_like!(current_customer)
    # すでに「いいね」されているか検索
    temp = Notification.where(["customer_id = ? and real_estate_id = ? and action = ? ", current_customer.id, customer_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
     notification = current_customer.active_notifications.new(
     real_estate_id: id,
     customer_id: custmer_id,
     action: 'Favorite'
      )
    end
  end
end