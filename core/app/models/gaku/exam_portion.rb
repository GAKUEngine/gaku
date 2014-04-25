module Gaku
  class ExamPortion < ActiveRecord::Base
    include ActiveModel::Dirty

    attr_accessor :custom_errors

    belongs_to :exam, counter_cache: true
    belongs_to :grading_method

    has_many :exam_schedules
    has_many :exam_portion_scores
    has_many :attachments, as: :attachable
    has_many :attendances, as: :attendancable

    validates :name, presence: true

    validates :weight,
              numericality: { greater_than_or_equal_to: 0,
                              if: proc { |ep| ep.weight.present? } }

    validates :max_score, presence: true,
                          numericality: { greater_than_or_equal_to: 0 }

    before_create :proper_position
    before_create :init_weight
    after_destroy :refresh_positions

    before_update :weight_calculate

    def to_s
      name
    end

    def correct_weight_with_error
      self.weight = weight_was
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
      if weight.nil?
        other_ep = exam.exam_portions
        percentage = 100 / (other_ep.count + 1)
        self.weight = percentage
        other_ep.update_all weight: percentage
      end
    end

    def student_score(student)
      exam_portion_scores.where(student_id: student.id).first
    end

    private

    def proper_position
      self.position = exam.exam_portions.count
    end

    def refresh_positions
      exam_portions = exam.exam_portions
      exam_portions.pluck(:id).each_with_index do |id, index|
        exam_portions.where(id: id).update_all(position: index)
      end
    end
  end
end
