class AddIsDemandToServices < ActiveRecord::Migration
  def change
    add_column :services, :is_demand, :boolean, :default => false
  end
end
