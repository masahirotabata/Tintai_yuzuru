class Notification < ApplicationRecord
  belongs_to :customer
  belongs_to :real_estate
end
