class CreateConsists < ActiveRecord::Migration
  def change
    create_table :consists do |t|
      t.references :base
      t.references :layer

      t.timestamps
    end
    add_index :consists, :base_id
    add_index :consists, :layer_id
  end
end
