class AddLanguageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :language, :string, :default => 'us'
  end
end
