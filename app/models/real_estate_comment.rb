class RealEstateComment < ApplicationRecord
  belongs_to :real_estate
  belongs_to :customer
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
end
