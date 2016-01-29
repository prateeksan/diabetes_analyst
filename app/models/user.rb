class User < ActiveRecord::Base
  
  has_secure_password
  has_many :patient_measurements, :patient_foods

  validates :username, :first_name, :last_name, :email, presence: true



  def extract_blood_sugar
    PatientMeasurement.all.each do |measurement|
  dates << measurement.measurement_time.mday
  values << measurement.blood_sugar_level
end
data = []
data << dates
data << values
    
  end



end