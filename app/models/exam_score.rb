class ExamScore < ActiveRecord::Base
  belongs_to :exam
  attr_accessible :score, :comment 

  validates :score, :numericality => { :greater_than_or_equal_to => 0 }, :presence => true
end

# == Schema Information
#
# Table name: exam_scores
#
#  id         :integer         not null, primary key
#  score      :float
#  comment    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  exam_id    :integer
#

