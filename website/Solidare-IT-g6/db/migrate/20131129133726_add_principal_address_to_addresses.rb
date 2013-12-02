class AddPrincipalAddressToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :principal, :boolean, :default => false
  end
end
