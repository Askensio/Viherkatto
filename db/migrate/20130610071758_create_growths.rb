class CreateGrowths < ActiveRecord::Migration
  def change
    create_table :growths do |t|
      t.references :plant
      t.references :growth_environment

      t.timestamps
    end
    add_index :growths, :plant_id
    add_index :growths, :growth_environment_id
  end
end
