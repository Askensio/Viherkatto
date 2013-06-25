class CreateBasePlants < ActiveRecord::Migration
  def change
    create_table :base_plants do |t|
      t.references :base
      t.references :plant

      t.timestamps
    end
    add_index :base_plants, :base_id
    add_index :base_plants, :plant_id
  end
end
