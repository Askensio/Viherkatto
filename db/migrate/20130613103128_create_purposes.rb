class CreatePurposes < ActiveRecord::Migration
  def change
    create_table :purposes do |t|
      t.string :value
      t.references :greenroof
      t.timestamps
    end

    add_index :purposes, :greenroof_id

  end
end
