class PatientMeasurement < ActiveRecord::Base

  belongs_to :user

  validates :weight, numericality: {greater_than: 0}
  validates :blood_sugar_level, numericality: {greater_than: 0}
  validates :systolic_pressure, numericality: {greater_than: 0}
  validates :diastolic_pressure, numericality: {greater_than: 0}

end



