require 'faker'

User.delete_all
PatientMedication.delete_all
PatientFood.delete_all
PatientMeasurement.delete_all


i = 0
5.times do 
  
  user = User.new
  user.username = ["test",i].join("")
  user.password = "1234"
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.birth_date =  Faker::Date.between(Date.new(1950), Date.new(1990))
  user.diagnosis_date = Faker::Date.between(Date.new(1990),Date.new(2013))
  user.height = (120..200).to_a.sample
  user.save
  i += 1
end

#short version to be used with user "test0" password "1234"

# 10.times do
#   med = PatientMedication.new
#   med.user = User.first
#   med.medication_id = (1..500).to_a.sample
#   med.quantity = (1..5).to_a.sample
#   med.medication_time = Faker::Date.between(30.days.ago, Date.today)
#   med.save
#   med.created_at = Faker::Date.between(10.days.ago, Date.today) 
#   med.save

#   time_fake = (DateTime.new(2016,1,1,12)..DateTime.new(2016,2)).to_a.sample
#   3.times do
#     meal = PatientFood.new
#     meal.user = User.first
#     meal.food_id = (1..1000).to_a.sample
#     meal.measure = (1..3).to_a.sample
#     meal.meal_time = time_fake
#     meal.save
#     meal.created_at = Faker::Date.between(10.days.ago, Date.today) 
#     meal.save
#   end

#   measure = PatientMeasurement.new
#   measure.user = User.first
#   measure.blood_sugar_level = (150..200).to_a.sample
#   measure.systolic_pressure = (90..200).to_a.sample
#   measure.diastolic_pressure = (70..100).to_a.sample
#   measure.weight = (70..78).to_a.sample
#   measure.measurement_time = Faker::Date.between(30.days.ago, Date.today)
#   measure.save  
#   measure.created_at = Faker::Date.between(10.days.ago, Date.today) 
#   measure.save 

# end



# Long version to be used to have a more realistic database with multiple users

50.times do
  med = PatientMedication.new
  med.user = User.all.sample
  med.medication_id = (1..500).to_a.sample
  med.din = Medication.find(med.medication_id).din
  med.name = Medication.find(med.medication_id).name
  med.quantity = (1..5).to_a.sample
  med.medication_time = Faker::Date.between(10.days.ago, Date.today)
  med.save
  med.created_at = Faker::Date.between(10.days.ago, Date.today) 
  med.save

  time_fake = (DateTime.new(2016,1,1,12)..DateTime.new(2016,2)).to_a.sample
  3.times do
    meal = PatientFood.new
    meal.user = User.all.sample
    meal.food_id = (1..1000).to_a.sample
    meal.name = Food.find(meal.food_id).name
    meal.meal_time = time_fake
    meal.measure = (1..3).to_a.sample
    meal.save
    meal.created_at = Faker::Date.between(5.days.ago, Date.today) 
    meal.save
  end

  measure = PatientMeasurement.new
  measure.user = User.all.sample
  measure.blood_sugar_level = (150..200).to_a.sample
  measure.systolic_pressure = (90..200).to_a.sample
  measure.diastolic_pressure = (70..100).to_a.sample
  measure.weight = (70..78).to_a.sample
  measure.measurement_time = Faker::Date.between(10.days.ago, Date.today)
  measure.save  
  measure.created_at = Faker::Date.between(10.days.ago, Date.today) 
  measure.save 
end

# require "./db/fake_data/fake_measurements.rb"
