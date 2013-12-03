class AddPrivacyToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :private, :boolean
    add_column :groups, :secret, :boolean
  end
end
