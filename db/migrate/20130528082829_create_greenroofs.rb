class CreateGreenroofs < ActiveRecord::Migration
  def change
    create_table :greenroofs do |t|
      t.belongs_to :user
      t.has_many :plants
      t.has_many :roofs
      t.has_many :bases
      t.string :address
      t.integer :purpose
      t.string :note

      t.timestamps
    end
    add_index :greenroofs, :user_id
  end
end
