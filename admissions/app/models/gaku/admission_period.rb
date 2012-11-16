module Gaku
  class AdmissionPeriod < ActiveRecord::Base
    has_many :admissions
    has_one :schedule
    has_many :admission_methods
    accepts_nested_attributes_for :admission_methods, :allow_destroy => true

    attr_accessible :name, :rolling, :seat_limit, :admitted_on, :admission_methods_attributes

  end
end