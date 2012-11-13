module Gaku
  class AdmissionMethod < ActiveRecord::Base
  	has_many :admission_phases
  	has_many :admissions
    belongs_to :admission_period

    attr_accessible :name, :admission_id, :admission_period_id
  end
end