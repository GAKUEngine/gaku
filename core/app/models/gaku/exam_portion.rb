module Gaku
	class ExamPortion < ActiveRecord::Base
	  belongs_to :exam
	  belongs_to :grading_method

	  has_many :exam_schedules
	  has_many :exam_portion_scores
	  has_many :attachments, :as => :attachable
	  has_many :attendances, :as => :attendancable

	  attr_accessible :name, :description, :max_score, :problem_count, :weight, :execution_date, :adjustments

	  validates :name, :presence => true

	  validates :weight, :numericality => { :greater_than_or_equal_to => 0 }
	  validates :max_score, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

	  before_create :proper_position
	  after_destroy :refresh_positions


	  def student_score(student)
	  	self.exam_portion_scores.where(:student_id => student.id).first
	  end

	  private

	  def proper_position
	 		self.position = self.exam.exam_portions.count
	  end

	  def refresh_positions
      exam_portions = self.exam.exam_portions
      exam_portions.pluck(:id).each_with_index do |id, index|
        exam_portions.update_all( {:position => index}, {:id => id} )
      end
    end

	end
end



