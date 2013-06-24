class CreateGreenroofs < ActiveRecord::Migration
  def change
    create_table :greenroofs do |t|
      t.string :address
      t.string :locality
      t.string :constructor
      t.integer :year
      t.text :note
      t.references :user
      t.references :role
      t.text :usage_experience

      t.timestamps
    end
    add_index :greenroofs, :user_id
  end
end
