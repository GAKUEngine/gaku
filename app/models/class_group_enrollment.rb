class ClassGroupEnrollment < ActiveRecord::Base
  belongs_to :class_group
  belongs_to :student
end