module Gaku
  class Course < ActiveRecord::Base

    include Notes, Gradable, Enrollable, Semesterable

    has_many :course_group_enrollments
    has_many :course_groups, through: :course_group_enrollments

    has_many :exam_schedules

    belongs_to :syllabus, required: false
    belongs_to :class_group, required: false

    delegate :name, :code, to: :syllabus, prefix: true, allow_nil: true

    # accepts_nested_attributes_for :enrollments

    validates :code, presence: true

    def to_s
      if syllabus_name
        "#{syllabus_name}-#{code}"
      else
        code
      end
    end

    def to_selectbox
      [to_s, id]
    end

    # def enroll_class_group(class_group)
    #   unless class_group.blank?
    #     ActiveRecord::Base.transaction do
    #       class_group.student_ids.each do |student_id|
    #         CourseEnrollment.find_or_create_by(student_id: student_id, course_id: id)
    #      end
    #     end
    #   end
    # end

  end
end
