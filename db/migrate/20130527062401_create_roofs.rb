class CreateRoofs < ActiveRecord::Migration
  def change
    create_table :roofs do |t|
      t.integer :declination
      t.integer :load_capacity
      t.integer :area
      t.references :light

      t.timestamps
    end

    add_index :roofs, [:declination, :load_capacity, :area],
              :unique => true,
              :name => 'roof_index'
  end
end
