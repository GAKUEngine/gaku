class Exam < ActiveRecord::Base

  has_many :exam_scores 
  has_many :exam_portions
  has_many :exam_portion_scores, :through => :exam_portions
  has_and_belongs_to_many :syllabuses

  belongs_to :schedule

  attr_accessible :name, :description, :problem_count, :max_score, :execution_date, :weight, :data, :schedule_id
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

