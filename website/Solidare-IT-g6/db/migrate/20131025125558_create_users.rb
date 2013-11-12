class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :firstname
      t.datetime :birthdate
      t.string :email
      t.integer :karma
      t.boolean :id_ok ,:default => 0
      t.text :presentation
      t.boolean :inscription_ok

      t.timestamps
    end
  end
end
