class CreateRealEstates < ActiveRecord::Migration[5.2]
   def change
    create_table :real_estates do |t|
      t.integer :category_id
      t.integer :customer_id
      t.integer :area_id
      t.string :real_estate_image_id
      t.string :image_id
      t.string :detail
      t.string :real_estate_name
      t.string :nearest_station
      t.string :kinds
      t.string :structure
      t.integer :date_of_construction
      t.string :floor_building
      t.string :parking
      t.integer :scheduled_to_move_out
      t.string :offer_price
      t.string  :comments
      t.integer :real_estate_status
      t.integer :image

      t.timestamps
    end
  end
end
