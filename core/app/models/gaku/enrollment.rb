module Gaku
  class Enrollment < ActiveRecord::Base

    belongs_to :student
    belongs_to :enrollable, polymorphic: true, counter_cache: true

    validates :enrollable_type, :enrollable_id, :student_id, presence: true

    validates :student_id,
              uniqueness: {
                scope: %w( enrollable_type enrollable_id ),
                message: I18n.t(:'student.already_enrolled')
              }

    validates :enrollable_type,
              inclusion: {
                in: %w( Gaku::Course Gaku::ClassGroup Gaku::ExtracurricularActivity Gaku::ExamSession ),
                message: '%{value} is not a valid'
              }

    validate :class_group_semesters_overlap, if: ->(record) { record.class_group_type? }

    before_create :increment_enrollable_counter
    before_destroy :decrement_enrollable_counter

    before_create :proper_position, if: ->(record) { record.class_group_type? }
    after_destroy :refresh_positions, if: ->(record) { record.class_group_type? }

    scope :seat_numbered, -> { order('seat_number ASC') }

    def class_group_type?
      enrollable_type == 'Gaku::ClassGroup'
    end

    def course_type?
      enrollable_type == 'Gaku::Course'
    end

    private

    def class_group_semesters_overlap
      if overlap_semester? && not_in_student_class_groups?
        errors.add(:base, I18n.t('enrollment.class_group_overlapping'))
      end
    end

    def overlap_semester?
      if student && student.semesters && enrollable
        student.semesters.where(id: enrollable.semester_ids).any?
      end
    end

    def not_in_student_class_groups?
      student.class_groups.exclude?(enrollable)
    end

    def increment_enrollable_counter
      Student.increment_counter(resource_name_counter, student.id) if student
    end

    def decrement_enrollable_counter
      Student.decrement_counter(resource_name_counter, student.id) if student
    end

    def resource_name_counter
      enrollable_type.demodulize.underscore.pluralize.concat('_count') if enrollable_type
    end

    def proper_position
      self.seat_number = enrollable.enrollments_count.next
    end

    def refresh_positions
      enrollments = enrollable.enrollments
      enrollments.pluck(:id).each_with_index do |id, index|
        enrollments.where(id: id).update_all(seat_number: index.next)
      end
    end

    def class_group_is_active?
      Gaku::ClassGroup.active.include?(enrollable)
    end

    def not_in_student_class_groups?
      student.class_groups.exclude?(enrollable)
    end

  end
end
