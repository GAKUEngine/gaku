module Gaku
  class AdmissionMethod < ActiveRecord::Base
  	has_many :admission_phases
  	belongs_to :admission
    belongs_to :admission_period

    attr_accessible :name, :admission_id
  end
end