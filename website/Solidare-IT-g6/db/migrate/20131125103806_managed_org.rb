class ManagedOrg < ActiveRecord::Migration
  def change
        add_column :users, :managed_org_id, :integer, default: -1
  end
end
