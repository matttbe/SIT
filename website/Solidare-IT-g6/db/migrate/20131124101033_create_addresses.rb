class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.integer :postal_code
      t.string :city
      t.string :country
      t.integer :user_id
      t.integer :orga_id

      t.timestamps
    end
  end
end
