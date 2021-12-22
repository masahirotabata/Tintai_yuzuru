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
  
  #通知機能
  def create_notification_by(current_user)
        notification = current_user.active_notifications.new(
          item_id: id,
          visited_id: user_id,
          action: "like"
        )
        notification.save if notification.valid?
    end

    def create_notification_comment!(current_user, comment_id)
        # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
        temp_ids = Comment.select(:user_id).where(item_id: id).where.not(user_id: current_user.id).distinct
        temp_ids.each do |temp_id|
            save_notification_comment!(current_user, comment_id, temp_id['user_id'])
        end
        # まだ誰もコメントしていない場合は、投稿者に通知を送る
        save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

    def save_notification_comment!(current_user, comment_id, visited_id)
        # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
        notification = current_user.active_notifications.new(
          item_id: id,
          comment_id: comment_id,
          visited_id: visited_id,
          action: 'comment'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.visiter_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
     end

end