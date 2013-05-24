class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :name
      t.string :latin_name
      t.string :colour
      t.integer :aestethic_appeal
      t.integer :maintenance
      t.integer :min_soil_thickness
      t.integer :weight
      t.integer :coverage
      t.integer :light_requirement
      t.string :note

      t.timestamps
    end
  end
end
