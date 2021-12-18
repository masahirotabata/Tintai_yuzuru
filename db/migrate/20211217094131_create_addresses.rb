class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :area,null: false
      t.text :text, null: false
      t.integer :prefecture_id,  null: false

      t.timestamps
    end
  end
end
