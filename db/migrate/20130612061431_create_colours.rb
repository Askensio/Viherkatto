class CreateColours < ActiveRecord::Migration
  def change
    create_table :colours do |t|
      t.string :value

      t.timestamps
    end
    add_index :colours, :value
  end
end
