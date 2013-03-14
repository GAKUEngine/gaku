module Gaku
  class Exam < ActiveRecord::Base

    include Notes

    has_many :exam_scores
    has_many :exam_portions, :order => :position
    has_many :exam_portion_scores, :through => :exam_portions
    has_many :exam_syllabuses
    has_many :syllabuses, :through => :exam_syllabuses
    has_many :attendances, :as => :attendancable

    belongs_to :grading_method


    validates_presence_of :name
    validates :weight, :numericality => {:allow_blank => true, :greater_than_or_equal_to => 0 }

    attr_accessible :name, :description, :weight,
                    :use_weighting, :is_standalone, :adjustments,
                    :exam_portions_attributes, :grading_method_id,
                    :has_entry_numbers

    accepts_nested_attributes_for :exam_portions


    def self.without_syllabuses
      includes(:syllabuses).where(:is_standalone => false).select {|p| p.syllabuses.length == 0 }
    end

    def total_weight
      exam_portions.inject(0) { |sum, p| p.weight ? sum + p.weight : sum }
    end

    def total_weight_except(portion)
      exam_portions.inject(0) do |sum, p|
        if portion == p
          sum
        else
          p.weight ? sum + p.weight : sum
        end
      end
    end


    def max_score
      exam_portions.inject(0) {|sum, p| sum + p.max_score }
    end

    def completion(students)
      total_records = total_records(students)
      completion_ratio = 1 - (ungraded(students)  / total_records.to_f)

      return (completion_ratio * 100).round(2)
    end

    def ungraded(students)
      ungraded = 0
      self.exam_portions.each do |ep|
        if ep.exam_portion_scores.nil?
          ungraded += students.count
          next
        end
        ep.exam_portion_scores.each {|eps| ungraded += 1 if check_record_completion?(eps) }
      end

      return ungraded
    end

    def total_records(students)
       self.exam_portions.count * students.count
    end

    def completed_by_students(students)
      completed = Array.new
      students.each do |student|
        completed.append(student.id) if self.completed_by_student?(student)
      end
      return completed
    end


    def completed_by_student?(student)
      state = true
      self.exam_portions.each do |ep|
        student_eps = ep.exam_portion_scores.detect {|eps| eps.student_id == student.id}
        state = false if check_record_completion?(student_eps)
      end

      return state
    end

    private

    def check_record_completion?(student_eps)
      student_eps.score.nil? && !student_eps.attendances.last.try(:attendance_type).try(:auto_credit)
    end
  end
end


