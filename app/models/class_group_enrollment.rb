class ClassGroupEnrollment < ActiveRecord::Base
  belongs_to :class_group
  belongs_to :student
  attr_accessible :class_group_id, :student_id 
end