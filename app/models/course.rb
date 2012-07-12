class Course < ActiveRecord::Base
  has_many :course_enrollments
  has_many :students, :through => :course_enrollments
  belongs_to :syllabus
  belongs_to :class_group

  accepts_nested_attributes_for :course_enrollments

  attr_accessible :code, :class_group_id, :syllabus_id 
end

# == Schema Information
#
# Table name: courses
#
#  id             :integer         not null, primary key
#  code           :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  faculty_id     :integer
#  syllabus_id    :integer
#  class_group_id :integer
#

