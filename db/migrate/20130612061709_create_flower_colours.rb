class CreateFlowerColours < ActiveRecord::Migration
  def change
    create_table :flower_colours do |t|
      t.references :colour
      t.references :plant

      t.timestamps
    end
    add_index :flower_colours, :colour_id
    add_index :flower_colours, :plant_id
  end
end
