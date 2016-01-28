require 'csv'
require 'pry'

data = CSV.read("./db/import/medicines.csv")#, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
header = ["din","name","form"]
#binding.pry
sym_head = header.map { |head| head.to_sym}
meds = []
data.each do |row|
  meds << Hash[sym_head.zip(row)]
end

foods_floats.each do |food|
  Food.create(food)
end
