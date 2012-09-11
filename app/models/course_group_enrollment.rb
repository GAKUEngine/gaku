class CourseGroupEnrollment < ActiveRecord::Base
  belongs_to :course
  belongs_to :course_group

  attr_accessible :course_id, :course_group_id 
end