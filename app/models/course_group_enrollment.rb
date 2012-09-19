# == Schema Information
#
# Table name: course_group_enrollments
#
#  id              :integer          not null, primary key
#  course_id       :integer
#  course_group_id :integer
#

class CourseGroupEnrollment < ActiveRecord::Base
  belongs_to :course
  belongs_to :course_group

  attr_accessible :course_id, :course_group_id 

  validates :course_group_id, :presence => true
  validates :course_id, :uniqueness => {:scope => :course_group_id, :message => "already enrolled to this course group!"}, :presence => true

end
