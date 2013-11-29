class RenameOrgaIdToCoworkers < ActiveRecord::Migration
  def change
        rename_column :coworkers, :org_id, :organisation_id
  end
end
