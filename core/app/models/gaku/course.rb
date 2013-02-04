module Gaku
  class Course < ActiveRecord::Base

    include Notes

    has_many :enrollments, class_name: "Gaku::CourseEnrollment"
    has_many :students, :through => :enrollments

    has_many :course_group_enrollments
    has_many :course_groups, :through => :course_group_enrollments

    has_many :class_groups, :through => :class_group_course_enrollments
    has_many :class_group_course_enrollments, :dependent => :destroy

    has_many :exam_schedules

    belongs_to :syllabus
    belongs_to :class_group

    accepts_nested_attributes_for :enrollments

    attr_accessible :code, :class_group_id, :syllabus_id

    validates_presence_of :code

    def enroll_class_group(class_group)
    	unless class_group.blank?
        ActiveRecord::Base.transaction do
          class_group.student_ids.each do |student_id|
      	 	  CourseEnrollment.find_or_create_by_student_id_and_course_id(student_id, self.id)
      	 end
        end
      end
    end

  end
end
