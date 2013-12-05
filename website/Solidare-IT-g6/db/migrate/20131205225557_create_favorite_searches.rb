class CreateFavoriteSearches < ActiveRecord::Migration
  def change
    create_table :favorite_searches do |t|
      t.integer :user_id, :default => 0
      t.string :q , :default => ""
      t.boolean :is_demand, :default => false
      t.boolean :is_active, :default => false
      t.boolean :is_karma, :default => false
      t.boolean :is_order_end, :default => false
      t.integer :category_id, :default => 1
      t.boolean :is_order_distance, :default => false

      t.timestamps
    end
  end
end
