class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :name
      t.string :latin_name
      t.integer :min_soil_thickness
      t.integer :weight
      t.integer :max_height
      t.integer :min_height
      t.references :light
      t.references :maintenance
      t.string :note

      t.timestamps
    end

    add_index :plants, :name, unique: true
  end
end
