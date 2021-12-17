class CreateAreas < ActiveRecord::Migration[5.2]
   # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to :prefecture
  def change
    create_table :areas do |t|

      t.timestamps
    end
  end
end
