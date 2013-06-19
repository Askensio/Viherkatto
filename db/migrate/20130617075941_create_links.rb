class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :link
      t.references :plant

      t.timestamps
    end
    add_index :links, :plant_id
  end
end
