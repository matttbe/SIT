class CreateCoworkers < ActiveRecord::Migration
  def change
    create_table :coworkers do |t|
      t.integer :org_id
      t.integer :user_id

      t.timestamps
    end
  end
end
