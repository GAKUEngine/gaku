class ExamPortionScore < ActiveRecord::Base
  belongs_to :exam_portion
  attr_accessible :score, :comment, :division

  validates :score, :numericality => { :greater_than_or_equal_to => 0 }, :presence => true

end

# == Schema Information
#
# Table name: exam_portion_scores
#
#  id              :integer         not null, primary key
#  score           :float
#  division        :integer
#  comment         :text
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  exam_portion_id :integer
#

