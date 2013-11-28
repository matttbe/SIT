class RemoveSuperAdminFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :superadmin, :boolean
  end
end
