class CreateGreenroofs < ActiveRecord::Migration
  def change
    create_table :greenroofs do |t|
      t.string :address
      t.integer :purpose
      t.string :note
      t.integer :user_id

      t.timestamps
    end
    add_index :greenroofs, :user_id
  end
end
