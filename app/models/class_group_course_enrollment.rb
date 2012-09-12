class ClassGroupCourseEnrollment < ActiveRecord::Base
  
  belongs_to :class_group
  belongs_to :course

  attr_accessible :class_group_id, :course_id
end
