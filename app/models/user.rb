class User < ActiveRecord::Base
  
  has_secure_password
  has_many :patient_measurements

  validates :username, :first_name, :last_name, :email, presence: true



  


  def extracting_blood_sugar
    pairs = []
    PatientMeasurement.all.each do |measurement|
      pairs << [measurement.measurement_time, measurement.blood_sugar_level]
    end
    # sorted_pairs = pairs.sort_by {|result| result[0]}
    # first_day = sorted_pairs.first[0].yday
    # result = sorted_pairs.map {|pair| [(pair[0].yday - first_day) + 1,pair[1]]}
    result = pairs.map { |pair| [pair[0].to_date.strftime("%b-%d"),pair[1]]}
    result.unshift ["Date","Sugar level"]
    result.to_json
  end


  def bmi_calculator
    (self.patient_measurements.last.weight.to_f / self.height.to_f / self.height.to_f * 10000).floor
  end

end