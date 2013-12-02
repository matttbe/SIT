class CreateGroupUserRelations < ActiveRecord::Migration
  def change
    create_table :group_user_relations do |t|
      t.references :user, index: true
      t.references :group, index: true

      t.timestamps
    end
  end
end
