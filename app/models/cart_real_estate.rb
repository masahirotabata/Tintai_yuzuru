class CartRealEstate < ApplicationRecord
  belongs_to :customer
  belongs_to :real_estate
  belongs_to :order
  

  def sum_of_price
    real_estate.add_tax_price * pieces
  end

  #scope real_estates_of_price, -> { inject(0){ |sum, real_estate| sum + real_estate.sum_of_price } }
end
