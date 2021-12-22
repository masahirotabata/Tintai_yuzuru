class CreateCartRealEstates < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_real_estates do |t|
      
      t.integer :customer_id
      t.integer :real_estate_id
      t.integer :pieces

      t.timestamps
    end
  end
end
