class AddCreatorIdToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :creator_id, :integer
  end
end
