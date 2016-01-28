require 'csv'
require 'pry'

data = CSV.read("./db/import/test.csv"), { encoding: "UTF-8"}#, headers: true, header_converters: :symbol, converters: :all})
header = ["any","din","name","form"]
#binding.pry
sym_head = header.map { |head| head.to_sym}
meds = []
data.each do |row|
  row.each do |x|
    meds << Hash[sym_head.zip(x)]
  end
end

meds.each do |medication|
  Medication.create(medication)
end
# binding.pry
# puts ""