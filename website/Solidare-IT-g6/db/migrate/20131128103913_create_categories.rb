class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.text :text
      t.integer :parent

      t.timestamps
    end

    add_column :services, :cat_id, :integer, :default => 1
  end
end
