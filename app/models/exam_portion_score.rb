class ExamPortionScore < ActiveRecord::Base
  belongs_to :exam_portion
  attr_accessible :score
end
# == Schema Information
#
# Table name: exam_portion_scores
#
#  id              :integer         not null, primary key
#  score           :float
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  exam_portion_id :integer
#

