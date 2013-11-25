class CoworkerOrg < ActiveRecord::Migration
  def change
      add_column :users, :coworker_org_id, :integer, default: -1
  end
end
