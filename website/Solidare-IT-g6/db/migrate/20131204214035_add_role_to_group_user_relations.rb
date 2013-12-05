class AddRoleToGroupUserRelations < ActiveRecord::Migration
  def change
    add_column :group_user_relations, :role, :string
  end
end
