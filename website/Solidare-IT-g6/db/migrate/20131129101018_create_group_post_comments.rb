class CreateGroupPostComments < ActiveRecord::Migration
  def change
    create_table :group_post_comments do |t|
      t.references :group_post, index: true
      t.references :user, index: true
      t.text :body

      t.timestamps
    end
  end
end
