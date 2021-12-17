class CreateNegotiates < ActiveRecord::Migration[5.2]
  def change
    create_table :negotiates do |t|
    
      t.integer :customer_id
      t.integer :real_estate_id
      t.integer :negotiation_status

      t.timestamps
    end
  end
end

     