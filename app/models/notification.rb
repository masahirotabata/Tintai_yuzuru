class Notification < ApplicationRecord
  belongs_to :real_estate, optional: true
  belongs_to :followed, class_name: 'Relationship', foreign_key: 'followed_id', optional: true
  belongs_to :follower, class_name: 'Relationship', foreign_key: 'follower_id', optional: true
 

  belongs_to :visitor, class_name: 'Customer', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'Customer', foreign_key: 'visited_id', optional: true
  
 
end
