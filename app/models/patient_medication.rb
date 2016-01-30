class PatientMedication < ActiveRecord::Base

   belongs_to :medication
   belongs_to :user

   validates :name, :medication_time, presence: true 

end 