class CreatePurposeGreenroofTable < ActiveRecord::Migration
  def up
    create_table :greenroofs_purposes, :id => false do |t|
      t.integer :purpose_id
      t.integer :greenroof_id
    end
  end

  def down
    drop_table :purposes_greenroofs
  end
end
