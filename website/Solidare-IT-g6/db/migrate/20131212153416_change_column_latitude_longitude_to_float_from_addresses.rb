class ChangeColumnLatitudeLongitudeToFloatFromAddresses < ActiveRecord::Migration
  def change
    change_column :addresses, :latitude, :float, :default => 0.0
    change_column :addresses, :longitude, :float, :default => 0.0
    change_column :users, :karma, :float, :default => 0.0
  end
end
