require 'roo'
require 'GenSheet'

module Gaku::Core::Importers::Students
  class RosterToStudent
    include Gaku::Core::Importers::Logger
    def initialize(row, logger = nil)
      @logger = logger

      student = Gaku::Student.new()
      reg_id(row, student)
      reg_name(row, student)
      reg_gender(row, student)
      reg_birthdate(row, student)
      student.save()
    end

    private
    def reg_id(row, student)
      log 'Student ID: ' + row['id'].to_s
      student.student_id_number = row['id'].to_s if row['id']
    end

    def reg_name(row, student)
      student.surname = row['surname']
      student.middle_name = row['middle_name']
      student.name = row['name']
      student.surname_reading = row['surname_reading']
      #student.middle_name_reading = row['middle_name_reading']
      student.name_reading = row['name_reading']
    end

    def reg_gender(row, student)
    end

    def reg_birthdate(row, student)
      student.birth_date = row['birth_date']
    end

  end
end

