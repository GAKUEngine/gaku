class ClassGroup < ActiveRecord::Base
  has_many :class_group_enrollments
  has_many :students, :through => :class_group_enrollments
  has_many :courses
  has_many :semesters
  
  attr_accessible :name, :grade, :homeroom
end

# == Schema Information
#
# Table name: class_groups
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  grade      :integer
#  homeroom   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  faculty_id :integer
#

