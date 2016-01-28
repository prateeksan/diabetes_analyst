class CreatePatientFoodsTable < ActiveRecord::Migration
  def change
    create_table :patient_foods do |t|
      t.references :user
      t.references :food
      t.string :name
      t.float :measure
      t.text :description
      t.datetime :meal_time
      t.timestamps
    end
  end
end
