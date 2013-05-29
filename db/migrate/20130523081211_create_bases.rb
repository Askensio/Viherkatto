class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|
      t.integer :absorbancy

      t.timestamps
    end
  end
end
