class AddCreatorToNotification < ActiveRecord::Migration
  def change
     add_column :notifications, :creator_id, :integer
  end
end
