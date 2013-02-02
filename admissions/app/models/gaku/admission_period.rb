module Gaku
  class AdmissionPeriod < ActiveRecord::Base

    has_one :schedule
    has_many :admissions

    has_many :period_method_associations
    has_many :admission_methods, :through => :period_method_associations

    accepts_nested_attributes_for :period_method_associations, :allow_destroy => true

    attr_accessible :name, :rolling, :seat_limit, :admitted_on, :period_method_associations_attributes

    validates  :name, presence: true

  end
end
