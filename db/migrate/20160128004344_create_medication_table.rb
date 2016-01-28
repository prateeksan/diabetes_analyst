class CreateMedicationTable < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.string :any
      t.string :din
      t.string :name
      t.string :form
      t.timestamps
    end
  end
end
