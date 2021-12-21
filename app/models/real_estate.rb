class RealEstate < ApplicationRecord
  belongs_to :category,optional: true
  has_many :favorites
  has_many :notifications
  belongs_to :customer,optional: true
  has_many :orders
  
  
   # フォローをした、されたの関係
has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

# 一覧画面で使う
has_many :followings, through: :relationships, source: :follow
has_many :followers, through: :reverse_of_relationships, source: :follower

def follow(customer_id)
  relationships.create(followed_id: customer_id)
end
# フォローを外すときの処理
def unfollow(user_id)
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