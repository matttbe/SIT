class RenameNotifiedUser < ActiveRecord::Migration
  def change
    rename_column :notifications, :type, :notification_type
  end
end
