# == Schema Information
#
# Table name: syllabuses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  code        :string(255)
#  description :text
#  credits     :integer
#  hours       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module Gaku
	class Syllabus < ActiveRecord::Base
	  has_many :courses
	  has_many :assignments
	  has_many :lesson_plans
	  has_many :exam_syllabuses
	  has_many :exams, :through => :exam_syllabuses
	  has_many :notes, as: :notable 

	  attr_accessible :name, :code, :description, :credits, :exams , :exams_attributes, :assignments, :assignments_attributes

	  accepts_nested_attributes_for :exams, :assignments

	  validates :name, :code, :presence => true  
	end
end


