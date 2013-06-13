class CreatePurposes < ActiveRecord::Migration
  def change
    create_table :purposes do |t|
      t.string :value
      t.timestamps
    end

    add_index :greenroof_id

  end
end
