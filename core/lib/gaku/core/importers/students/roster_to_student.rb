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
      student.save()
    end

    private
    def reg_id(row, student)
      log 'Student ID: ' + row['id'].to_s
      student.student_id_number = row['id'].to_s if row['id']
    end

    def reg_name(row, student)
      student.name = row['name']
      student.surname = row['surname']
    end


  end
end

