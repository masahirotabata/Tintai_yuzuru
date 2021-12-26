class Order < ApplicationRecord
    # has_one :cart_real_estate, dependent: :destroy
    belongs_to :customer
    belongs_to :real_estate

  enum order_status: { waiting: 0,  done: 1 }
  

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
end
