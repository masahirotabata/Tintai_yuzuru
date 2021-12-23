class Negotiate < ApplicationRecord
    
  belongs_to :customer
  belongs_to :real_estate
  belongs_to :order
  belongs_to :follower, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"
  belongs_to :following, class_name: "Customer",optional: true
  belongs_to :customer, optional: true
  belongs_to :real_estate,optional: true
  has_many :favorites
  has_many :post_comments, dependent: :destroy

  # フォローをした、されたの関係
has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

# 一覧画面で使う
has_many :followings, through: :active_relationships, source: :followed
has_many :followers, through: :passive_relationships, source: :follower
 
def follow(customer_id)
  relationships.create(followed_id: customer_id)
end
# フォローを外すときの処理
def unfollow(customer_id)
  relationships.find_by(followed_id: customer_id).destroy
end
# フォローしているか判定
def following?(customer)
 followings.include?(customer)
end

def matchers
  following & followers
end

end
