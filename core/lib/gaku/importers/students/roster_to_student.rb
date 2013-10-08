require 'GenSheet'

module Gaku::Importers::Students
  class RosterToStudent
    include Gaku::Importers::Logger
    include Gaku::Importers::Students::StudentIdentity
    include Gaku::Importers::Students::PersonalInformation

    def initialize(row, info, logger = nil)
      @logger = logger
      I18n.locale = info['locale'].to_sym.presence || I18n.default_locale

      student = find_or_create_student(row)
      reg_id(row, student)
      reg_name(row, student)
      reg_sex(row, student)
      reg_birthdate(row, student)
      student.save

      add_contacts(row, student)
      add_address(row, student)
    end

    private

    def find_or_create_student(row)
      student = find_student_by_student_ids(row[:student_id_number], row[:student_foreign_id_number])

      unless student.nil?
        log "Updating student record with Student ID[#{
          student.student_id_number}]."
        return student
      end

      log 'Registering new student from importer.'
      student = Gaku::Student.new
      student.enrollment_status = Gaku::EnrollmentStatus.find_by_code('enrolled')
      student
    end

    def reg_id(row, student)
      student.student_id_number = normalize_id_num(row[:student_id_number])
      student.student_foreign_id_number = normalize_id_num(row[:student_foreign_id_number])
    end

    def reg_name(row, student)
      if (!row[:surname].nil? && row[:surname] != '')
        student.surname = row[:surname]
        student.middle_name = row[:middle_name]
        student.name = row[:name]
        student.surname_reading = row[:surname_reading]
        student.middle_name_reading = row[:middle_name_reading]
        student.name_reading = row[:name_reading]
      elsif (!row[:full_name].nil? && row[:full_name] != '')
        name_parts = row[:full_name].sub('　', ' ').split(' ')
        student.surname = name_parts.first
        student.name = name_parts.last

        name_reading_parts = row[:full_name_reading].sub('　', ' ').split(' ')
        student.surname_reading = name_reading_parts.first
        student.name_reading = name_reading_parts.last
      else
        log 'Could not read student name for: ' + row
      end
    end
  end
end
