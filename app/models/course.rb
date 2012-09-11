# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  code           :string(255)
#  faculty_id     :integer
#  syllabus_id    :integer
#  class_group_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Course < ActiveRecord::Base
  has_many :course_enrollments
  has_many :students, :through => :course_enrollments
  has_many :exam_schedules
  belongs_to :syllabus
  
  has_many :class_group_course_enrollments, :dependent => :destroy
  has_many :class_groups, :through => :class_group_course_enrollments
  
  has_and_belongs_to_many :course_groups

  accepts_nested_attributes_for :course_enrollments

  attr_accessible :code, :class_group_id, :syllabus_id 

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
