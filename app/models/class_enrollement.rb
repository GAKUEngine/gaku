class ClassEnrollement < ActiveRecord::Base
  belongs_to :student
  belongs_to :school_class
end
