class AddAddressIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :address_id, :integer
  end
end
