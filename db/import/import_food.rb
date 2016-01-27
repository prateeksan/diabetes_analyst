require 'csv'
require 'pry'

data = CSV.read("food_table.csv")#, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
header = ["number","name","measure","weight","kcal","kj","protein","carbohydrate",
          "total_sugar","total_dietary_fibre","total_fat","calcium","iron","sodium",
          "potassium","magnesium","phosphorus","vitamin_a","beta_carotene","lycopene","folate","vitamin_c", "vitamin_b12"]

sym_head = header.map { |head| head.to_sym}
foods = []
data.each do |row|
  foods << Hash[sym_head.zip(row)]
end

foods_floats = []

foods.each do |hash| 
  new_hash = {}
  hash.each do |key,value|
    case key
    when :Food_Name
      new_hash[:Food_Name] = value
    when :Measure
      new_hash[:Measure] = value
    else
      new_hash[key] = value.to_f
    end
  end
  foods_floats << new_hash
end



