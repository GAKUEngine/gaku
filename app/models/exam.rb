class Exam < ActiveRecord::Base

  has_many :exam_scores 
  has_many :exam_portions
  has_many :exam_portion_scores, :through => :exam_portions
  has_and_belongs_to_many :syllabuses
  has_one :grading_method


  belongs_to :schedule

  attr_accessible :name, :description, :weight, :schedule_id, :dynamic_scoring, :adjustments

  validates :name, :max_score, :presence => true
end
# == Schema Information
#
# Table name: exams
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  description    :text
#  problem_count  :integer
#  max_score      :float
#  weight         :float
#  data           :binary
#  execution_date :datetime
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  schedule_id    :integer
#

