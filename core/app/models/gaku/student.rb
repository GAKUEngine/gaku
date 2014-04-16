module Gaku
  class Student < ActiveRecord::Base

    include Person, Addresses, Contacts, Notes, Picture, Pagination

    has_many :course_enrollments, dependent: :destroy
    has_many :courses, through: :course_enrollments

    has_many :class_group_enrollments,  inverse_of: :student
    has_many :class_groups, through: :class_group_enrollments

    has_many :extracurricular_activity_enrollments
    has_many :extracurricular_activities, through: :extracurricular_activity_enrollments

    has_many :student_exam_sessions
    has_many :exam_sessions, through: :student_exam_sessions

    has_many :student_specialties
    has_many :specialties, through: :student_specialties
    has_one :major_specialty, conditions: ["gaku_student_specialties.major = ?", true]

    has_many :badges
    has_many :badge_types, through: :badges

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

    accepts_nested_attributes_for :guardians, allow_destroy: true
    accepts_nested_attributes_for :class_group_enrollments,
        reject_if: proc { |attributes| attributes[:class_group_id].blank? }



    before_create :set_scholarship_status
    before_create :set_foreign_id_code
    after_create  :set_serial_id
    after_save   :set_code

    def add_to_selection
      hash = { id: "#{id}", full_name: "#{surname} #{name}" }
      $redis.rpush(:student_selection, hash.to_json)
    end

    def remove_from_selection
      hash = { id: "#{id}", full_name: "#{surname} #{name}" }
      $redis.lrem(:student_selection, 0, hash.to_json)
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

    def self.specialties
      student_specialties.map &:name
    end

    def self.active
      where(enrollment_status_code: EnrollmentStatus.active.pluck(:code))
    end

    def set_scholarship_status
      self.scholarship_status = ScholarshipStatus.find_by(default: true)
    end

    def set_foreign_id_code
      if preset = Preset.active
        if preset.increment_foreign_id_code == '1'
          self.foreign_id_code = (preset.last_foreign_id_code.to_i + 1).to_s
          preset.last_foreign_id_code = foreign_id_code
          preset.save!
        else
          if foreign_id_code.to_i.is_a? Integer
            preset.increment_foreign_id_code = true
            preset.last_foreign_id_code = foreign_id_code
            preset.save!
          end
        end
      end
    end

    def active
      enrollment_status = EnrollmentStatus.find_by(code: enrollment_status_code)
      if enrollment_status
        enrollment_status.active?
      else
        false
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
      update_column(:serial_id, "%05d" % id)
    end

    def empty_string(size)
      '*' * size
    end
  end
end
