class PatientMedication < ActiveRecord::Base

   belongs_to :medication
   belongs_to :user


end 