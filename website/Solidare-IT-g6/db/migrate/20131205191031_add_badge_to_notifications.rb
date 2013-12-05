class AddBadgeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :badge, :integer
  end
end
