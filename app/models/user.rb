class User < ActiveRecord::Base
  
  has_secure_password
  has_many :patient_measurements 
  has_many :patient_foods

  validates :username, :first_name, :last_name, :email, presence: true

  
  def extracting_measurements_for_graph(measurement)
    user = self
    pairs = []
    case measurement
    when "sugar_level"
      PatientMeasurement.all.each do |measurement|
        if measurement.blood_sugar_level
          pairs << [measurement.measurement_time, measurement.blood_sugar_level]
        end
      end
      header = ["Date","Sugar level"]
    when "pressure"
      PatientMeasurement.all.each do |measurement|
        if measurement.systolic_pressure || measurement.diastolic_pressure
          pairs << [measurement.measurement_time, 
                    measurement.systolic_pressure, 
                    measurement.diastolic_pressure]
        end
      end
      header = ["Date", "Systolic pressure", "Diastolic pressure"]
    when "weight"
      PatientMeasurement.all.each do |measurement|
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
      if pair[1].length == 2
        measurement2.push pair[1][1]
      end
    end
    result = []
    result << dates 
    result << measurement1
    unless measurement2.empty?
      result << measurement2      
    end
    result      
  end
  

  # def bmi_calculator
  #   (self.patient_measurements.last.weight.to_f / self.height.to_f / self.height.to_f * 10000).floor
  # end

end