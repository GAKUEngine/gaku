module Gaku
  class Student < ActiveRecord::Base
    include Person, Addresses, Contacts, Notes, Picture, Pagination

    has_many :enrollments, dependent: :destroy

    has_many :course_enrollments,
      -> { where(enrollmentable_type: 'Gaku::Course') }, class_name: 'Gaku::Enrollment'
    has_many :class_group_enrollments,
      -> { where(enrollmentable_type: 'Gaku::ClassGroup') }, class_name: 'Gaku::Enrollment'
    has_many :extracurricular_activity_enrollments,
      -> { where(enrollmentable_type: 'Gaku::ExtracurricularActivity') }, class_name: 'Gaku::Enrollment'

    with_options through: :enrollments, source: :enrollmentable do |assoc|
      assoc.has_many :courses, source_type: 'Gaku::Course'
      assoc.has_many :class_groups, source_type: 'Gaku::ClassGroup'
      assoc.has_many :extracurricular_activities, source_type: 'Gaku::ExtracurricularActivity'
    end

    has_many :semesters, through: :class_groups

    has_many :student_exam_sessions
    has_many :exam_sessions, through: :student_exam_sessions

    has_many :student_specialties
    has_many :specialties, through: :student_specialties
    has_one  :major_specialty, -> { where('gaku_student_specialties.major = ?', true) }

    has_many :badges
    has_many :badge_types, through: :badges

    has_many :student_guardians, dependent: :destroy
    has_many :guardians, through: :student_guardians

    has_many :exam_portion_scores
    has_many :assignment_scores
    has_many :attendances
    has_many :external_school_records
    has_many :simple_grades
    has_many :semester_attendances

    belongs_to :user
    belongs_to :commute_method_type
    belongs_to :scholarship_status
    belongs_to :enrollment_status, foreign_key: :enrollment_status_code, primary_key: :code

    accepts_nested_attributes_for :guardians, allow_destroy: true

    before_create :set_scholarship_status
    after_create  :set_serial_id
    after_save    :set_code

    def full_name
      "#{surname} #{name}"
    end

    def self.specialties
      student_specialties.map & :name
    end

    def self.active
      where(enrollment_status_code: EnrollmentStatus.active.pluck(:code))
    end

    def make_enrolled
      enrollment_status = EnrollmentStatus.where(
        code: 'enrolled',
        active: true,
        immutable: true).first_or_create!.try(:code)
      update_column(:enrollment_status_code, enrollment_status)
      save
    end

    def major_specialty
      student_specialties.ordered.first.specialty if student_specialties.any?
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

    def set_scholarship_status
      self.scholarship_status = ScholarshipStatus.find_by(default: true)
    end

    def active
      enrollment_status = EnrollmentStatus.find_by(code: enrollment_status_code)
      if enrollment_status
        enrollment_status.active?
      else
        false
      end
    end

    def temp_gender
      if gender
        I18n.t('gender.male')
      else
        I18n.t('gender.female')
      end

    end

    private

    def major_specialty_code
      major_specialty || empty_string(2)
    end

    def admitted_code
      admitted.try(:year) || empty_string(4)
    end

    def set_code
      update_column(:code, "#{major_specialty_code}-#{admitted_code}-#{serial_id}")
    end

    def set_serial_id
      update_column :serial_id, format('%05d', id)
    end

    def empty_string(size)
      '*' * size
    end
  end
end
