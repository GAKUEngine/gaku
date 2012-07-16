class Exam < ActiveRecord::Base

  has_many :exam_scores 
  has_many :exam_portions
  has_many :exam_portion_scores, :through => :exam_portions
  has_and_belongs_to_many :syllabuses
  has_one :grading_method


  attr_accessible :name, :description, :weight, :dynamic_scoring, :adjustments

  validates :name, :presence => true
end


# == Schema Information
#
# Table name: exams
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  description     :text
#  adjustments     :text
#  weight          :float
#  dynamic_scoring :boolean
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

