class CreateLayers < ActiveRecord::Migration
  def change
    create_table :layers do |t|
      t.string :name
      t.integer :thickness
      t.integer :weight

      t.timestamps
    end
  end
end
