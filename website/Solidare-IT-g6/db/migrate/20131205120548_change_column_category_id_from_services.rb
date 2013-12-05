class ChangeColumnCategoryIdFromServices < ActiveRecord::Migration
  def change
    change_column :services, :category_id, :integer, :default => 1
    remove_column :services, :cat_id
  end
end
