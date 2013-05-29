class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :roof
      t.references :environment

      t.timestamps
    end
    add_index :locations, :roof_id
    add_index :locations, :environment_id
  end
end
