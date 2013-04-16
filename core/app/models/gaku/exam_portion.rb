module Gaku
  class ExamPortion < ActiveRecord::Base
    include ActiveModel::Dirty

    attr_accessor :custom_errors

    belongs_to :exam
    belongs_to :grading_method

    has_many :exam_schedules
    has_many :exam_portion_scores
    has_many :attachments, :as => :attachable
    has_many :attendances, :as => :attendancable

    attr_accessible :name, :description, :max_score, :problem_count, :weight, :execution_date, :adjustments

    validates :name, :presence => true

    validates :weight, :numericality => {
                          :greater_than_or_equal_to => 0,
                          :if => Proc.new { |exam_portion| exam_portion.weight.present? }
                          }

    validates :max_score, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

    before_create :proper_position
    before_create :init_weight
    after_destroy :refresh_positions

    before_update :weight_calculate

    def correct_weight_with_error
      self.weight = weight_was
      self.custom_errors =  I18n.t(:'exam_portion.error')
    end

    def weight_calculate
      if (exam.total_weight_except(self) + weight) > 100
        last = exam.exam_portions.last

        interval = weight - weight_was
        if self != last
          if interval <= last.weight
            last.update_attribute(:weight, last.weight - interval)
          else
            correct_weight_with_error
          end
        else
          correct_weight_with_error
        end

      end
    end

    def init_weight
      if self.weight.nil?
        other_ep = exam.exam_portions
        percentage = 100 / (other_ep.count + 1)
        self.weight = percentage
        other_ep.update_all :weight => percentage
      end
    end

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



