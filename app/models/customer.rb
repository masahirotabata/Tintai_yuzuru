class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
 has_many :favorites
 has_many :post_comments, dependent: :destroy
 has_many :order_real_estates
 has_many :real_estates

  # フォローをした、されたの関係
has_many :active_relationships, class_name: "Relationship",
                 foreign_key: "follower_id",
                 dependent: :destroy
# has_many :followings, class_name: "Relationship", foreign_key:"followed_id" , dependent: :destroy
has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

# # 一覧画面で使う
# has_many :followings, through: :relationships, source: :followed
# has_many :followers, through:  :reverse_of_relationships, source: :follower

  has_many :active_relationships,
  class_name: 'Relationship',
  foreign_key: 'follower_id'
    
  has_many :following, 
  through: :active_relationships, 
  source: :followed
  
  has_many :passive_relationships,
  class_name: 'Relationship',
  foreign_key: 'followed_id'
    
  has_many :followers, 
  through: :passive_relationships, 
  source:  :follower
  
  # has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # has_many :followers, through: :reverse_of_relationships, source: :customer
 
  # def follow(other_customer)
  #   unless self == other_customer
     
  #     self.relationships.find_or_create_by(follow_id: other_customer.id)
  #   end
  # end

  # def unfollow(other_customer)
  #   relationship = self.relationships.find_by(follow_id: other_customer.id)
  #   relationship.destroy if relationship
  # end

  # def following?(following)
  #   self.followings.include?(following)
  # end
  
  #ユーザーをフォローする
  def follow(other_customer)
    self.active_relationships.create(followed_id: other_customer.id)
  end
  
  #ユーザーをフォロー解除する
  def  unfollow(other_customer)
    self.active_relationships.find_by(followed_id: other_customer.id).destroy
    
  end
  
  #現在のユーザーがフォローしてたらtrueを返す
  def following?(other_customer)
    self.following.include?(other_customer)
  end
  
  def matching
    @matchers = following & followers
  end

  

end
