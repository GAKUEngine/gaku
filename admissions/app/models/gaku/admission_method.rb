module Gaku
  class AdmissionMethod < ActiveRecord::Base

    has_many :admission_phases, :order => :position
    has_many :admissions

    has_many :period_method_associations
    has_many :admission_periods, :through => :period_method_associations

    attr_accessible :name, :admission_id, :admission_period_id, :starting_applicant_number

    validates :name, :presence => true

  end
end
