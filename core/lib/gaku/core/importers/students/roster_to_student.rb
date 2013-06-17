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
      student.student_id_number = row['student_id_number'].to_s
      student.student_foreign_id_number = row['student_foreign_id_number'].to_s
    end

    def reg_name(row, student)
      student.surname = row['surname']
      student.middle_name = row['middle_name']
      student.name = row['name']
      student.surname_reading = row['surname_reading']
      student.middle_name_reading = row['middle_name_reading']
      student.name_reading = row['name_reading']
    end

    def reg_gender(row, student)
    end

    def reg_birthdate(row, student)
      #birth_date = Date.strptime(row['birth_date']).to_s
      #begin
      #  birth_date = Date.strptime(row['birth_date'].to_s, "%Y/%m/%d")
      #rescue
      #  birth_date = Date.civil(1899, 12, 31) + row['birth_date'].to_i.days - 1.day
      #end
      student.birth_date = row['birth_date']
    end

  end
end

