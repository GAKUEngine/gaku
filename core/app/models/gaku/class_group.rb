module Gaku
  class ClassGroup < ActiveRecord::Base
    include Notes, Pagination

    has_many :enrollments, class_name: 'Gaku::ClassGroupEnrollment'
    has_many :students, through: :enrollments

    has_many :class_group_course_enrollments, dependent: :destroy
    has_many :courses, through: :class_group_course_enrollments

    has_many :semester_class_groups, dependent: :destroy
    has_many :semesters, through: :semester_class_groups

    validates :name, presence: true

    scope :without_semester, -> {
      includes(:semester_class_groups)
      .where(gaku_semester_class_groups: { class_group_id: nil })
    }

    def to_s
      "#{grade} - #{name}"
    end
  end
end
