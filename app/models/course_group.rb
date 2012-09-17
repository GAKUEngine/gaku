# == Schema Information
#
# Table name: course_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CourseGroup < ActiveRecord::Base
  attr_accessible :name

  has_many :course_group_enrollments
  has_many :courses, :through => :course_group_enrollments

  validates :name, :presence => true
end
