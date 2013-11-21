class AddOrganisationToServices < ActiveRecord::Migration
  def change
    add_column :services, :org_id, :integer
  end
end
