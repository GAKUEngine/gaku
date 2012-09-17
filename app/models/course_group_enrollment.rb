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

  validates :course_group_id, :uniqueness => {:scope => :course_id, :message => "Already enrolled to course group!"},
  											:presence => true
  validates :course_id, :presence => true

end
