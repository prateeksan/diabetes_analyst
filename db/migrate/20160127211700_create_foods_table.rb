class CreateFoodsTable < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.float :number
      t.string :name
      t.string :measure
      t.float :weight
      t.float :kcal
      t.float :kj
      t.float :protein
      t.float :carbohydrate
      t.float :total_sugar
      t.float :total_dietary_fibre
      t.float :total_fat
      t.float :calcium
      t.float :iron
      t.float :sodium
      t.float :potassium
      t.float :magnesium
      t.float :phosphorus
      t.float :vitamin_a
      t.float :beta_carotene
      t.float :lycopene
      t.float :folate
      t.float :vitamin_c
      t.float :vitamin_b12
      t.timestamps
    end
  end
end

