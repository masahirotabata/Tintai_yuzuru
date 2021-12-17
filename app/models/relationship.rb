class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"
  belongs_to :following, class_name: "Customer",optional: true
  belongs_to :customer, optional: true
  belongs_to :real_estate,optional: true
end
