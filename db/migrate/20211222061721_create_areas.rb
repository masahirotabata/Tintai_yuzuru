class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.integer :customer_id
      t.integer :real_estate_id
      t.integer :real_estate_erea, null: false, default: 0
      

      t.timestamps
    end
  end
end
