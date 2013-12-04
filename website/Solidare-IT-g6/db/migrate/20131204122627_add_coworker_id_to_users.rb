class AddCoworkerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coworker_id, :integer, default =>-1
  end
end
