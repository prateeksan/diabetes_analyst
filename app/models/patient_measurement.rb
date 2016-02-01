class PatientMeasurement < ActiveRecord::Base

  belongs_to :user

  validates :weight, presence: true, numericality: {greater_than: 0}
  validates :blood_sugar_level, presence: true, numericality: {greater_than: 0}
  validates :systolic_pressure, presence: true, numericality: {greater_than: 0}
  validates :diastolic_pressure, presence: true, numericality: {greater_than: 0}
  validates :measurement_time, presence: true

end



