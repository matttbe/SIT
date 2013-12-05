class ChangeColumnIdUsedDefaultValues < ActiveRecord::Migration
  def change
    change_column :addresses, :number, :integer, :default => 0
    change_column :addresses, :postal_code, :integer, :default => 0
    change_column :addresses, :user_id, :integer, :default => 0
    change_column :addresses, :orga_id, :integer, :default => 0
    change_column :addresses, :latitude, :integer, :default => 0
    change_column :addresses, :longitude, :integer, :default => 0
    change_column :categories, :parent, :integer, :default => 0
    change_column :services, :org_id, :integer, :default => 0
    change_column :services, :address_id, :integer, :default => 0
    change_column :transactions, :service_id, :integer, :default => 0
    change_column :transactions, :user_id, :integer, :default => 0
    change_column :users, :karma, :integer, :default => 0
    change_column :users, :coworker_id, :integer, :default => 0
    change_column :users, :coworker_org_id, :integer, :default => 0
    change_column :users, :managed_org_id, :integer, :default => 0
    change_column :users, :inscription_ok, :boolean, :default => false
  end
end
