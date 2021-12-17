class CreateOrderRealEstates < ActiveRecord::Migration[5.2]
 def change
    create_table :order_real_estates do |t|
      t.integer :order_id
      t.integer :real_estate_id
      t.integer :tax_price
      t.integer :negotiation_status
      t.integer :commission
      t.integer :tax

      t.timestamps
    end
  end
end
