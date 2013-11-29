class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.text :feedback_comments
      t.integer :feedback_evaluation
      t.integer :service_id
      t.integer :user_id

      t.timestamps
    end
  end
end
