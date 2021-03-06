class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|
      t.integer :absorbancy
      t.string :name
      t.references :greenroof
      t.text :note

      t.timestamps
    end
    add_index :bases, :greenroof_id
  end
end
