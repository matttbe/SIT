class AddManagedByOrganisationToUser < ActiveRecord::Migration
  def change
    add_column :users, :managed_by_organisation, :integer, :default=false
  end
end
