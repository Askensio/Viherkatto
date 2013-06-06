class CreateCustomPlants < ActiveRecord::Migration
  def change
    create_table :custom_plants do |t|
      t.string :name
      t.references :greenroof

      t.timestamps
    end

    add_index :custom_plants, :greenroof_id
  end
end
