class ClassGroupEnrollment < ActiveRecord::Base
  belongs_to :class_group
  belongs_to :student
  has_many :roles

  attr_accessible :roles, :class_group_id, :student_id
end