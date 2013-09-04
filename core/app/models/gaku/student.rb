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
                            :is_deleted
                          ]

    accepts_nested_attributes_for :guardians, allow_destroy: true

    before_create :set_scholarship_status

    def make_enrolled
      enrollment_status = EnrollmentStatus.where( code: 'enrolled',
                            is_active: true, immutable: true).first_or_create!.try(:code)
      update_column(:enrollment_status_code, enrollment_status)
      save
    end

    def identification_number
      "%surname-%name-%id".gsub(/%(\w+)/) do |s|
        case s
        when "%name"
          name.downcase
        when "%surname"
          surname.downcase
        when "%id"
          id
        end
      end
    end

    def self.specialties
      student_specialties.map &:name
    end

    def set_scholarship_status
      self.scholarship_status = ScholarshipStatus.find_by_is_default(true)
    end

    def is_active
      enrollment_status = EnrollmentStatus.find_by_code(self.enrollment_status_code)
      if enrollment_status
        enrollment_status.is_active
      else
        false
      end
    end

    #returns full name complete with formatting [if any]
    def formatted_name
      student_names
    end

    def formatted_name_reading
      student_names reading: true
    end

    # return full name without formatting but in order,
    # with spaces between portions
    def full_name
      student_names without_formating: true
    end

    def full_name_reading
      student_names without_formating: true, reading: true
    end

    def student_names(options = {})
      @names_preset ||= Gaku::Preset.get(:names)
      preset = @names_preset

      if options[:without_formating]
        preset_without_format = String.new
        preset.gsub(/%(\w+)/) {|n|  preset_without_format << n + ' '}
        preset = preset_without_format.strip
      end

      if options[:reading] && name_reading.blank? && surname_reading.blank? && middle_name_reading.blank?
        return ''
      end

      reading = options[:reading]
      if preset.blank?
        return reading ? self.phonetic_reading : self.to_s
      end
      result = preset.gsub(/%(\w+)/) do |name|
        case name
        when '%first' then proper_name(:name, reading)
        when '%middle' then proper_name(:middle_name, reading)
        when '%last' then proper_name(:surname, reading)
        end
      end
      return result.gsub(/[^[[:word:]]\s]/, '').gsub(/\s+/, " ").strip if middle_name.blank?
      result.gsub(/\s+/, " ").strip
    end

  private

    def proper_name(attribute, reading)
      reading ? self.send(attribute.to_s + '_reading') : self.send(attribute)
    end


  end
end
