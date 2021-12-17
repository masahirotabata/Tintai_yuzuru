class CreateNotifications < ActiveRecord::Migration[5.2]
 def change
    create_table :notifications do |t|
      t.integer :customer_id,index: true, null: false
      t.integer :real_estate_id,index: true, null: false
     
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

  
  end
end
