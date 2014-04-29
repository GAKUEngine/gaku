module Gaku
  class Enrollment < ActiveRecord::Base

    belongs_to :student
    belongs_to :enrollmentable, polymorphic: true, counter_cache: true

    validates :enrollmentable_type, :enrollmentable_id, :student_id, presence: true

    validates :student_id,
       uniqueness: {
                     scope: [ :enrollmentable_type, :enrollmentable_id ],
                     message: I18n.t(:'student.already_enrolled')
                   }

    validates :enrollmentable_type,
      inclusion: {
        in: %w(Gaku::Course Gaku::ClassGroup Gaku::ExtracurricularActivity),
        message: "%{value} is not a valid"
      }

    before_create :increment_enrollmentable_counter
    before_destroy :decrement_enrollmentable_counter

    private


    def increment_enrollmentable_counter
      Student.increment_counter(resource_name_counter, student.id) if student
    end

    def decrement_enrollmentable_counter
      Student.decrement_counter(resource_name_counter, student.id) if student
    end

    def resource_name_counter
      if enrollmentable_type
        enrollmentable_type.demodulize.underscore.pluralize.concat('_count')
      end
    end

  end
end
