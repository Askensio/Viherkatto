class CreateGreenroofs < ActiveRecord::Migration
  def change
    create_table :greenroofs do |t|
      t.string :address
      t.integer :purpose
      t.text :note
      t.references :user

      t.timestamps
    end
    add_index :greenroofs, :user_id
  end
end
