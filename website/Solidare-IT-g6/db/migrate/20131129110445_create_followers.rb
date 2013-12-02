class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :user_id
      t.integer :service_id

      t.timestamps
    end
  end
end
