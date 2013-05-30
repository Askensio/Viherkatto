class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|
      t.integer :absorbancy
      t.references :greenroof

      t.timestamps
    end
    add_index :bases, :greenroof_id
  end
end
