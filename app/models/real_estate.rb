class RealEstate < ApplicationRecord
  belongs_to :category,optional: true
  has_many :favorites
  has_many :notifications
  belongs_to :customer,optional: true
  has_many :orders
  has_one :areas
  has_many :notifications, dependent: :destroy
  has_many :cart_real_estates
  has_many :real_estate_comments
  has_many :favorited_customers, through: :favorites, source: :real_estate
  attachment :image
  
  
  # フォローをした、されたの関係
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :follow
  has_many :followers, through: :reverse_of_relationships, source: :follower

  enum area_id:{
     "---":0,
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46, 
     沖縄県:47
   }
   
  enum production_status: { unable: 0, waiting: 1, working: 2, completed: 3 }
  enum order_status: { waiting_for_deposit: 0, confirmed_payment: 1, in_production: 2, ready_to_delivery: 3, done: 4 }


    # attachment :image
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
        @real_estate = RealEstate.where(area_id:　word)
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