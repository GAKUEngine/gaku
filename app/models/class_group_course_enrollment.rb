# == Schema Information
#
# Table name: class_group_course_enrollments
#
#  id             :integer          not null, primary key
#  class_group_id :integer
#  course_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ClassGroupCourseEnrollment < ActiveRecord::Base
  
  belongs_to :class_group
  belongs_to :course

  attr_accessible :class_group_id, :course_id

  validates :course_id, :uniqueness => {:scope => :class_group_id, :message => "Already enrolled to the class group!"}
  validates :course_id, :presence => true
end
