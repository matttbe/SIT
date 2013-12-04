class CreateAcceptServices < ActiveRecord::Migration
  def change
    create_table :accept_services do |t|
      t.integer :service_id
      t.integer :user_id
      t.boolean :is_chosen_customer

      t.timestamps
    end
  end
end
