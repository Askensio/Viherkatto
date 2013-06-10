class CreateMaintains < ActiveRecord::Migration
  def change
    create_table :maintains do |t|
      t.references :plant
      t.references :maintenance

      t.timestamps
    end
    add_index :maintains, :plant_id
    add_index :maintains, :maintenance_id
  end
end
