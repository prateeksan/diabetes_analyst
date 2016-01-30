class CreatePatientMedicationsTable < ActiveRecord::Migration
  def change
     create_table :patient_medications do |t|
      t.references :user
      t.references :medication
      t.integer :din
      t.string :name
      t.float :quantity      
      t.datetime :medication_time
      t.timestamps
    end
  end
end
