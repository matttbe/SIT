class AddNotifToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mail_notif, :boolean, :default => false
  end
end
