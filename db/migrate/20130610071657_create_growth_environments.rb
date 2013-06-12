class CreateGrowthEnvironments < ActiveRecord::Migration
  def change
    create_table :growth_environments do |t|
      t.string :environment

      t.timestamps
    end
  end
end
