class Syllabus < ActiveRecord::Base
  has_many :courses
  has_many :assignments
  has_and_belongs_to_many :exams

  attr_accessible :name, :code, :description, :credits, :exams , :exams_attributes, :assignments, :assignments_attributes

  accepts_nested_attributes_for :exams, :assignments
end



# == Schema Information
#
# Table name: syllabuses
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  code        :string(255)
#  description :text
#  credits     :integer
#  hours       :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

