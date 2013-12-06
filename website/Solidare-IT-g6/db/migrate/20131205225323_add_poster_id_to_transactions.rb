class AddPosterIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :poster_id, :integer
  end
end
