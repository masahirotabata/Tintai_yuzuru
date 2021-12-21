class Relationship < ApplicationRecord
  # belongs_to :follower, class_name: "Customer"
  # belongs_to :followed, class_name: "Customer"
  # belongs_to :following, class_name: "Customer",optional: true
  belongs_to :followed, class_name: 'Customer'
  belongs_to :real_estate,optional: true
  belongs_to :follower, class_name: 'Customer'
  

  validates :followed_id, presence: true
  validates :follower_id, presence: true
end
