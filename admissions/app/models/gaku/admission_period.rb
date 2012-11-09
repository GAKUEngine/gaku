module Gaku
  class AdmissionPeriod < ActiveRecord::Base
    has_many :admissions
    has_one :schedule
    has_many :admission_methods

    attr_accessible :name, :rolling, :seat_limit, :admitted_on

  end
end