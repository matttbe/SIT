class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :notified_user
      t.string :type
      t.integer :service_id

      t.timestamps
    end
  end
end
