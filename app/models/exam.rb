# == Schema Information
#
# Table name: exams
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  adjustments       :text
#  weight            :float
#  use_weighting     :boolean          default(FALSE)
#  is_standalone     :boolean          default(FALSE)
#  grading_method_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Exam < ActiveRecord::Base

  has_many :exam_scores 
  has_many :exam_portions
  has_many :exam_portion_scores, :through => :exam_portions
  has_many :exam_syllabuses
  has_many :syllabuses, :through => :exam_syllabuses 
  belongs_to :grading_method

  has_many :attendances, :as => :attendancable

  attr_accessible :name, :description, :weight, :use_weighting, :is_standalone, :adjustments, :exam_portions_attributes

  accepts_nested_attributes_for :exam_portions

  validates :name, :presence => true
  validates :weight, :numericality => {:allow_blank => true, :greater_than_or_equal_to => 0 }

  after_create :build_default_exam_portion

  scope :without_syllabuses, includes(:syllabuses).where(:is_standalone => false).select {|p| p.syllabuses.length == 0 }


  def max_score
    maxScore = 0.0
    self.exam_portions.each do |portion|
      maxScore += portion.max_score
    end
    
    return maxScore
  end

  private
    def build_default_exam_portion
      if self.exam_portions.any? 
        exam_portion = self.exam_portions.first
      else 
        exam_portion = self.exam_portions.create(:name => self.name)
      end

      exam_portion.is_master = true
      if self.name == ""
        exam_portion.name = self.name
      end
      exam_portion.save
    end

end


