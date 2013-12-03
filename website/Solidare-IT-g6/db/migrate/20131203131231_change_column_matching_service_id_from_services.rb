class ChangeColumnMatchingServiceIdFromServices < ActiveRecord::Migration
  def change
    change_column :services, :matching_service_id, :integer, :default => 0
  end
end
