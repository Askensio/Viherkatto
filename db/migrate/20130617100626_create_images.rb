class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :photo
      t.string :thumb
      t.references :greenroof

      t.timestamps
    end
  end
end
