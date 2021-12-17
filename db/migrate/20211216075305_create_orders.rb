class CreateOrders < ActiveRecord::Migration[5.2]
 def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :real_estate_id
      t.integer :negotiate_real_estate_id
      t.integer :order_date
      t.integer :moving_schedule_date
      t.string :partner_name
      t.integer :payment_method
      t.integer :commission
      t.integer :order_status

      t.timestamps
    end
  end
end
