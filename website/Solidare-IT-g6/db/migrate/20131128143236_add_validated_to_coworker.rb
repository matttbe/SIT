class AddValidatedToCoworker < ActiveRecord::Migration
  def change
    add_column :coworkers, :validated, :boolean, :default=>false
  end
end
