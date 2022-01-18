class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
       
       t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end


#   def change
#     create_table :relationships do |t|
#       t.references :customer, foreign_key: true
#       t.references :follow, foreign_key: { to_table: :customers }
      
#       t.timestamps
      
#       t.index [:customer_id, :follow_id], unique: true
#     end
#   end

    
    
   