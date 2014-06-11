module Gaku
  class Enrollment < ActiveRecord::Base

    belongs_to :student
    belongs_to :enrollmentable, polymorphic: true, counter_cache: true

    validates :enrollmentable_type, :enrollmentable_id, :student_id, presence: true

    validates :student_id,
              uniqueness: {
                scope: %w( enrollmentable_type enrollmentable_id ),
                message: I18n.t(:'student.already_enrolled')
              }

    validates :enrollmentable_type,
              inclusion: {
                in: %w( Gaku::Course Gaku::ClassGroup Gaku::ExtracurricularActivity ),
                message: '%{value} is not a valid'
              }

    validate :class_group_semesters_overlap, if: ->(record) { record.class_group_type? }

    before_create :increment_enrollmentable_counter
    before_destroy :decrement_enrollmentable_counter

    before_create :proper_position, if: ->(record) { record.class_group_type? }
    after_destroy :refresh_positions, if: ->(record) { record.class_group_type? }

    scope :seat_numbered, -> { order('seat_number ASC') }

    def class_group_type?
      enrollmentable_type == 'Gaku::ClassGroup'
    end

    private

    def class_group_semesters_overlap
      if overlap_semester? && not_in_student_class_groups?
        errors.add(:base, 'A student cannot belong to two Class Groups with overlapping semesters')
      end
    end

    def overlap_semester?
      if student && student.semesters
        student.semesters.where(id: enrollmentable.semester_ids).any?
      end
    end

    def not_in_student_class_groups?
      student.class_groups.exclude?(enrollmentable)
    end

    def increment_enrollmentable_counter
      Student.increment_counter(resource_name_counter, student.id) if student
    end

    def decrement_enrollmentable_counter
      Student.decrement_counter(resource_name_counter, student.id) if student
    end

    def resource_name_counter
      enrollmentable_type.demodulize.underscore.pluralize.concat('_count') if enrollmentable_type
    end

    def proper_position
      self.seat_number = enrollmentable.enrollments_count.next
    end

    def refresh_positions
      enrollments = enrollmentable.enrollments
      enrollments.pluck(:id).each_with_index do |id, index|
        enrollments.where(id: id).update_all(seat_number: index.next)
      end
    end

    def class_group_is_active?
      Gaku::ClassGroup.active.include?(enrollmentable)
    end

    def not_in_student_class_groups?
      student.class_groups.exclude?(enrollmentable)
    end

  end
end
