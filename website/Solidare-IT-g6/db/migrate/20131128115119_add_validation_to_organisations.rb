class AddValidationToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :validated, :boolean,:default => false
  end
end
