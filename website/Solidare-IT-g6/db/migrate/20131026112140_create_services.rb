class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.text :description
      t.date :dateStart
      t.date :dateEnd

      t.timestamps
    end
  end
end
