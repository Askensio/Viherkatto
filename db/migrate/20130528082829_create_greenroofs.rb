class CreateGreenroofs < ActiveRecord::Migration
  def change
    create_table :greenroofs do |t|
      t.string :name
      t.string :content
      t.belongs_to :user
      t.has_many :plants
      t.has_one :roof

      t.timestamps
    end
    add_index :greenroofs, :user_id
  end
end
