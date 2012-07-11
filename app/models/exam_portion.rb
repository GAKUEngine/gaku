class ExamPortion < ActiveRecord::Base
  belongs_to :exam
  has_many :exam_portion_scores
  attr_accessible :name, :max_score, :weight
end
# == Schema Information
#
# Table name: exam_portions
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  max_score  :float
#  weight     :float
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  exam_id    :integer
#

