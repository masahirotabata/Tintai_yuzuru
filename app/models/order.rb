class Order < ApplicationRecord
    has_one :cart_real_estate, dependent: :destroy
    belongs_to :customer

  enum order_status: { waiting_for_deposit: 0, confirmed_payment: 1, in_production: 2, ready_to_delivery: 3, done: 4 }

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
end
