class CreateCartRealEstates < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_real_estates do |t|

      t.timestamps
    end
  end
end
