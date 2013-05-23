class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|
      t.integer :thickness
      t.integer :weight
      t.string :material
      t.integer :absorbancy
      t.string :note

      t.timestamps
    end
  end
end
