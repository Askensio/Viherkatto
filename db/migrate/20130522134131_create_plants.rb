class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :name
      t.string :latin_name
      t.integer :maintenance
      t.integer :min_soil_thickness
      t.integer :weight
      t.integer :height
      t.references :light
      t.string :note

      t.timestamps
    end

    add_index :plants, :name, unique: true
  end
end
