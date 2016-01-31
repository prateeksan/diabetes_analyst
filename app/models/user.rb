class User < ActiveRecord::Base
  
  has_secure_password

  has_many :patient_measurements
  has_many :patient_foods
  has_many :patient_medications

  validates :username, :first_name, :last_name, :email, presence: true

  
  def extracting_measurements_for_graph(measurement)
    user = self
    pairs = []
    case measurement
    when "sugar_level"
      patient_measurements.each do |measurement|
        if measurement.blood_sugar_level
          pairs << [measurement.measurement_time, measurement.blood_sugar_level]
        end
      end
      header = ["Date","Sugar level"]
    when "pressure"
      patient_measurements.each do |measurement|
        if measurement.systolic_pressure || measurement.diastolic_pressure
          pairs << [measurement.measurement_time, 
                    measurement.systolic_pressure, 
                    measurement.diastolic_pressure]
        end
      end
      header = ["Date", "Systolic pressure", "Diastolic pressure"]
    when "weight"
      patient_measurements.each do |measurement|
        if measurement.weight
          pairs << [measurement.measurement_time, measurement.weight]
        end
      end
      header = ["Date","weight"]
    end
    sorted_pairs = pairs.sort_by {|pair| pair[0]}
    result = sorted_pairs.map { |pair| [pair[0].to_date.strftime("%b-%d"),pair[1..-1]]}
    dates = []
    measurement1 = []
    measurement2 = []
    result.each do |pair|
      dates.push pair[0]
      measurement1.push pair[1][0]
      if pair.length == 2
        measurement2.push pair[1][1]
      end
    end
    output = []
    output << dates 
    output << measurement1
    output << measurement2      
    output      
  end
  

  ####For now I have it in the user model but will transfer to have it as a helper
  #### Call the  User.first.nutrient_counter("total_fat") or any other nutrient described on the food table
  #### It will return a hash where the key is the day and the value is the amount of that nutrient consumed on that day

  def unify_meals_per_day
  user = self
  meals = {}
  sorted_food = user.patient_foods.order(meal_time: :desc)
  unique_days = sorted_food.select(:meal_time).uniq
  unique_days.each do |date|
    begining_day = date.meal_time.to_date.to_datetime
    end_day = (date.meal_time + 1.day).to_date.to_datetime - 1.second
    meals[date.meal_time.to_date.to_s.to_sym] = sorted_food.where(meal_time: begining_day..end_day)
  end
  meals
end


  def nutrient_counter_history(nutrient)
    meals = self.unify_meals_per_day
    result = {}
    meals.each do |day, foods|
      amount = 0
      foods.each do |food_item|
        amount += Food.find(food_item.food_id)[nutrient.to_sym] * food_item.measure
        #binding.pry
      end
      result[day] = amount
    end
    result
  end


  def nutrient_counter_day(nutrient)

  end

  def bmi_calculator
    (self.patient_measurements.last.weight.to_f / self.height.to_f / self.height.to_f * 10000).floor
  end


end