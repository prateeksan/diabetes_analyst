class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.date :birth_date
      t.date :diagnosis_date
      t.integer :height
      t.text :medical_history
      t.timestamps
    end
  end
end
