class CreatePlanteds < ActiveRecord::Migration
  def change
    create_table :planteds do |t|
      t.references :greenroof
      t.references :plant

      t.timestamps
    end
    add_index :planteds, :greenroof_id
    add_index :planteds, :plant_id
  end
end
