# == Schema Information
#
# Table name: class_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  grade      :integer
#  homeroom   :string(255)
#  faculty_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Gaku 
	class ClassGroup < ActiveRecord::Base
	  has_many :class_group_enrollments
	  has_many :students, :through => :class_group_enrollments
	  
	  has_many :class_group_course_enrollments, :dependent => :destroy
	  has_many :courses, :through => :class_group_course_enrollments
	  
	  has_many :semesters
	  has_many :notes, as: :notable 
	  
	  attr_accessible :name, :grade, :homeroom

	  validates :name, :presence => true
	end
end
