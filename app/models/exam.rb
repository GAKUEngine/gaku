# == Schema Information
#
# Table name: exams
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  adjustments       :text
#  weight            :float
#  dynamic_scoring   :boolean
#  grading_method_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Exam < ActiveRecord::Base

  has_many :exam_scores 
  has_many :exam_portions
  has_many :exam_portion_scores, :through => :exam_portions
  has_and_belongs_to_many :syllabuses
  belongs_to :grading_method

  attr_accessible :name, :description, :weight, :use_weighting, :adjustments, :exam_portions_attributes

  accepts_nested_attributes_for :exam_portions

  validates :name, :presence => true
  validates :weight, :numericality => {:allow_blank => true, :greater_than_or_equal_to => 0 }

  after_create :build_default_exam_portion

  def max_score
    maxScore = 0.0
    self.exam_portions.each do |portion|
      maxScore += portion.max_score
    end
    
    return maxScore
  end

  private
    def build_default_exam_portion
      exam_portion = self.exam_portions.first
      exam_portion.is_master = true
      if self.name == ""
        exam_portion.name = self.name
      end
      exam_portion.save
    end

end


