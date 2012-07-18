class Exam < ActiveRecord::Base

  has_many :exam_scores 
  has_many :exam_portions
  has_many :exam_portion_scores, :through => :exam_portions
  has_and_belongs_to_many :syllabuses
  has_one :grading_method

  attr_accessible :name, :description, :weight, :dynamic_scoring, :adjustments, :exam_portions_attributes

  accepts_nested_attributes_for :exam_portions

  validates :name, :presence => true

  after_create :build_default_exam_portion


  private
    def build_default_exam_portion
      exam_portion = ExamPortion.create(:name => self.name)
      exam_portion.is_master = true
      self.exam_portions << exam_portion
    end

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

