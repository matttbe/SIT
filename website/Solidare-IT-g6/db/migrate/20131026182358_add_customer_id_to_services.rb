class AddCustomerIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :customer_id, :integer
  end
end
