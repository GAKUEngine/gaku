module Gaku
  class Course < ActiveRecord::Base
    include Notes, Gradable

    has_many :enrollments,
             class_name: 'Gaku::CourseEnrollment',
             dependent: :destroy

    has_many :students, through: :enrollments

    has_many :course_group_enrollments
    has_many :course_groups, through: :course_group_enrollments

    has_many :class_groups, through: :class_group_course_enrollments
    has_many :class_group_course_enrollments, dependent: :destroy

    has_many :semester_courses, dependent: :destroy
    has_many :semesters, through: :semester_courses

    has_many :exam_schedules

    belongs_to :syllabus
    belongs_to :class_group

    delegate :name, :code, to: :syllabus, prefix: true, allow_nil: true

    accepts_nested_attributes_for :enrollments

    validates :code, presence: true

    scope :without_semester, -> { includes(:semester_courses).where(gaku_semester_courses: { course_id: nil }) }

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

    def enroll_class_group(class_group)
      unless class_group.blank?
        ActiveRecord::Base.transaction do
          class_group.student_ids.each do |student_id|
            CourseEnrollment.find_or_create_by(student_id: student_id, course_id: id)
          end
        end
      end
    end
  end
end
