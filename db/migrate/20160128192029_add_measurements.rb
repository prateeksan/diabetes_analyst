class AddMeasurements < ActiveRecord::Migration
  def change
    create_table :patient_measurements do |t|
      t.references :user
      t.integer :blood_sugar_level
      t.integer :systolic_pressure
      t.integer :diastolic_pressure
      t.float :weight
      t.datetime :measurement_time
      t.timestamps
    end
  end
end
