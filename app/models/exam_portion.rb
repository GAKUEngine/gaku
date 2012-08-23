# == Schema Information
#
# Table name: exam_portions
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  max_score         :float
#  weight            :float            default(100.0)
#  problem_count     :integer
#  description       :text
#  adjustments       :text
#  is_master         :boolean          default(FALSE)
#  exam_id           :integer
#  grading_method_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ExamPortion < ActiveRecord::Base
  belongs_to :exam
  belongs_to :grading_method

  has_many :exam_schedules
  has_many :exam_portion_scores
  has_many :files

  attr_accessible :name, :description, :max_score, :problem_count, :weight, :execution_date, :adjustments

  validates :name, :presence => true

  validates :weight, :numericality => { :greater_than_or_equal_to => 0 }
  validates :problem_count, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :max_score, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

end



