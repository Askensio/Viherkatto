class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :otsikko
      t.string :osoite
      t.string :email
      t.string :puhelin
      t.string :note

      t.timestamps
    end
  end
end
