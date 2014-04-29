module Gaku
  class Exam < ActiveRecord::Base
    include Notes, Pagination, Gradable

    has_many :exam_scores
    has_many :exam_portions, -> { order :position }
    has_many :exam_portion_scores, through: :exam_portions

    has_many :exam_syllabuses, dependent: :destroy
    has_many :syllabuses, through: :exam_syllabuses

    has_many :attendances, as: :attendancable

    has_many :exam_sessions

    belongs_to :grading_method
    belongs_to :department

    validates :name, presence: true

    validates :weight, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

    accepts_nested_attributes_for :exam_portions

    def to_s
      name
    end

    def self.without_syllabuses
      includes(:syllabuses).where(standalone: false)
                           .select { |p| p.syllabuses.length == 0 }
    end

    def total_weight
      exam_portions.reduce(0) { |sum, p| p.weight ? sum + p.weight : sum }
    end

    def total_weight_except(portion)
      exam_portions.reduce(0) do |sum, p|
        if portion == p
          sum
        else
          p.weight ? sum + p.weight : sum
        end
      end
    end

    def max_score
      exam_portions.reduce(0) { |sum, p| sum + p.max_score }
    end

    def completion(students)
      total_records = total_records(students)
      completion_ratio = 1 - (ungraded(students) / total_records.to_f)
      (completion_ratio * 100).round(2)
    end

    def ungraded(students)
      ungraded = 0

      students.each do |student|
        student_exam_eps = exam_portion_scores.select do |eps|
          eps.student_id == student.id
        end

        student_exam_eps.each do |eps|
          ungraded += 1 if check_record_completion?(eps)
        end
      end

      ungraded
    end

    def total_records(students)
      exam_portions.count * students.count
    end

    def completed_by_students(students)
      completed = []
      students.each do |student|
        completed.append(student.id) if self.completed_by_student?(student)
      end
      completed
    end

    def completed_by_student?(student)
      state = true

      exam_portions.each do |ep|
        student_eps = ep.exam_portion_scores.find do |eps|
          eps.student_id == student.id
        end
        state = false if check_record_completion?(student_eps)
      end

      state
    end

    def check_record_completion?(student_eps)
      student_eps.score.nil? && !student_eps.attendances
                                            .last
                                            .try(:attendance_type)
                                            .try(:auto_credit)
    end
  end
end
