class CreateRoofs < ActiveRecord::Migration
  def change
    create_table :roofs do |t|
      t.integer :declination
      t.integer :load_capacity
      t.string :enviroment
      t.integer :area
      t.references :light



      t.timestamps
    end

    add_index :roofs, [:declination, :load_capacity, :enviroment, :area],
              :unique => true,
              :name => 'roof_index'
  end
end
