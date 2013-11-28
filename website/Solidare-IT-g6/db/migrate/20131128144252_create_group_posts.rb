class CreateGroupPosts < ActiveRecord::Migration
  def change
    create_table :group_posts do |t|
      t.references :group, index: true
      t.references :user, index: true
      t.text :body
      t.datetime :time

      t.timestamps
    end
  end
end
