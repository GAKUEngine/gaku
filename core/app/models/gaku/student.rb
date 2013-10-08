module Gaku
  class Student < ActiveRecord::Base

    include Person, Addresses, Contacts, Notes, Picture, Trashable

    has_many :course_enrollments, dependent: :destroy
    has_many :courses, through: :course_enrollments

    has_many :class_group_enrollments
    has_many :class_groups, through: :class_group_enrollments

    has_many :extracurricular_activity_enrollments
    has_many :extracurricular_activities, through: :extracurricular_activity_enrollments

    has_many :student_specialties
    has_many :specialties, through: :student_specialties

    has_many :student_achievements
    has_many :achievements, through: :student_achievements

    has_many :student_guardians, dependent: :destroy
    has_many :guardians, through: :student_guardians

    has_many :exam_portion_scores
    has_many :assignment_scores
    has_many :attendances
    has_many :external_school_records
    has_many :simple_grades

    belongs_to :user
    belongs_to :commute_method_type
    belongs_to :scholarship_status
    belongs_to :enrollment_status, foreign_key: :enrollment_status_code, primary_key: :code


    has_paper_trail class_name: 'Gaku::Versioning::StudentVersion',
                    on: [:update, :destroy],
                    only: [
                            :name, :surname, :middle_name,
                            :student_id_number, :student_foreign_id_number,
                            :scholarship_status_id,
                            :commute_method_type_id, :enrollment_status_code,
                            :deleted
                          ]

    accepts_nested_attributes_for :guardians, allow_destroy: true

    before_create :set_scholarship_status

    paginates_per Preset.students_per_page

    def make_enrolled
      enrollment_status = EnrollmentStatus.where( code: 'enrolled',
                                                  active: true, immutable: true).first_or_create!.try(:code)
      update_column(:enrollment_status_code, enrollment_status)
      save
    end

    def identification_number
      '%surname-%name-%id'.gsub(/%(\w+)/) do |s|
        case s
        when '%name'
          name.downcase
        when '%surname'
          surname.downcase
        when '%id'
          id
        end
      end
    end

    def self.specialties
      student_specialties.map &:name
    end

    def self.active
      where(enrollment_status_code: EnrollmentStatus.active.pluck(:code))
    end

    def set_scholarship_status
      self.scholarship_status = ScholarshipStatus.find_by_default(true)
    end

    def active
      enrollment_status = EnrollmentStatus.find_by_code(enrollment_status_code)
      if enrollment_status
        enrollment_status.active?
      else
        false
      end
    end

  end
end
