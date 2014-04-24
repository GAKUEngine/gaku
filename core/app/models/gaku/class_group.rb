module Gaku
  class ClassGroup < ActiveRecord::Base

    include Notes, Pagination, Enrollmentable, Semesterable

    # has_many :enrollments, class_name: 'Gaku::ClassGroupEnrollment'
    # has_many :students, through: :enrollments

    # has_many :class_group_course_enrollments, dependent: :destroy
    # has_many :courses, through: :class_group_course_enrollments
    # has_many :class_group_enrollments, dependent: :destroy
    # has_many :courses, through: :class_group_enrollments,
    #                    source: :class_group_enrollmentable,
    #                    source_type: "Gaku::Course"


    validates :name, presence: true

    def to_s
      "#{grade} - #{name}"
    end

  end
end
