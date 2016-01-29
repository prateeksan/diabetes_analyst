current_date = 10.day.ago
10.times do 
  
  measure = PatientMeasurement.new
  measure.user = User.first
  measure.blood_sugar_level = (150..200).to_a.sample
  measure.systolic_pressure = (90..200).to_a.sample
  measure.diastolic_pressure = (50..160).to_a.sample
  measure.weight = (70..78).to_a.sample
  measure.measurement_time = current_date
  measure.save  
  current_date += 1.day
  puts current_date
end

# require "./db/fake_data/fake_measurements.rb"
