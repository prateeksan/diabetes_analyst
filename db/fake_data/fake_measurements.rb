current_date = DateTime.new(2000)
10.times do 
  
  measure = PatientMeasurement.new
  measure.user = User.first
  measure.blood_sugar_level = (150..200).to_a.sample
  measure.measurement_time = current_date
  measure.save  
  current_date += 1
end

# require "./db/fake_data/fake_measurements.rb"

dates = []
values = []
PatientMeasurement.all.each do |measurement|
  dates << measurement.measurement_time.mday
  values << measurement.blood_sugar_level
end
data = []
data << dates
data << values
require 'googlecharts'

puts Gchart.line_xy( :theme => :thirty7signals,
                      :title => 'blood_sugar_level',
                      :data => data,
                      :axis_with_labels => 'x',
                      :size => '400x400',
                      #:legend => results.keys,
                      :encoding => 'text',
                      :max_value => 'false'
                     ).sub!('chds=,', 'chds=a')
