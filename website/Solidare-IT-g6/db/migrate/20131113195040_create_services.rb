class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.text :description
      t.datetime :date_start
      t.datetime :date_end
      t.boolean :quick_match ,:default => false
      t.integer :matching_service_id, :default => -1
      t.integer :creator_id

      t.timestamps
    end
  end
end
