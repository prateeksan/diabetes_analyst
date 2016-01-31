class PatientFood < ActiveRecord::Base


  belongs_to :food
  belongs_to :user

  validates :name, :measure, :meal_time, presence: true
  validates :measure, numericality: {greater_than: 0}

end