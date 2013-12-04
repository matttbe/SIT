class AddManagedByOrganisationToUser < ActiveRecord::Migration
  def change
    add_column :users, :managed_by_organisation, :boolean, :default => false
  end
end
