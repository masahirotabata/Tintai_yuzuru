class RealEstate < ApplicationRecord
  belongs_to :category,optional: true
  has_many :favorites
  has_many :notifications
  belongs_to :customer,optional: true
  has_many :orders
  has_many :areas
  has_many :notifications, dependent: :destroy
  
  
   # フォローをした、されたの関係
has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

# 一覧画面で使う
has_many :followings, through: :relationships, source: :follow
has_many :followers, through: :reverse_of_relationships, source: :follower

def follow(customer_id)
  relationships.create(followed_id: customer_id)
end
# フォローを外すときの処理
def unfollow(customer_id)
  relationships.find_by(followed_id: customer_id).destroy
end
# 現在のユーザーがフォローしてたらtrueを返す
  def following?(follow)
    followings.include?(follow)
  end


# def matchers
#   followings & followers
# end

	
 
    
    
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
  
 def create_notification_like!(current_customer)
    # すでに「フォロー」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and customer_id = ? and action = ? ", current_customer.id, customer_id, id, 'follow'])
    # フォローされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_customer.active_notifications.new(
        customer_id: id,
        visited_id: customer_id,
        action: 'follow'
      )
      # 自分に対するフォローの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  #通知機能
  def create_notification_by(current_customer)
        notification = current_customer.active_notifications.new(
          real_estate_id: id,
          visited_id: customer_id,
          action: "follow"
        )
        notification.save if notification.valid?
    end

   def create_notification_real_estate!(current_customer, real_estate_id)
    # 自分以外に物件投稿している人をすべて取得し、全員に通知を送る
    temp_ids = real_estate.select(:customer_id).where(real_estate_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_real_estate!(current_customer, real_estate_id, temp_id['customer_id'])
    end
    # まだ誰も物件投稿していない場合は、投稿者に通知を送る
    save_notification_real_estate!(current_customer, real_estate_id, customer_id) if temp_ids.blank?
  end

  def save_notification_real_estate!(current_customer, real_estate_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_customer.active_notifications.new(
      real_estate_id: id,
      visited_id: visited_id,
      action: 'real_estate'
    )
  end
end