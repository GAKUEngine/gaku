module Gaku
  class AdmissionMethod < ActiveRecord::Base
  	has_many :admission_phases
  	 
    attr_accessible :name
  end
end