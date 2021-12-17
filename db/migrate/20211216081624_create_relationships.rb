class CreateRelationships < ActiveRecord::Migration[5.2]
 def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.integer :following
      t.references :customer, foreign_key: true
      t.references :follow, foreign_key: { to_table: :customers }
      t.index [:customer_id, :follow_id], unique: true
      t.timestamps
    end
  end
end
