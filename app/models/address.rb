class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :perefecture

  validates :area, :text, presence: true

  validates :prefecture_id, numericality: { other_than: 1 } 
end
