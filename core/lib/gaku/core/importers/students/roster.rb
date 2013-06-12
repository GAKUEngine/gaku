# -*- encoding: utf-8 -*-
require 'roo'
require 'GenSheet'

module Gaku
  module Core
    module Importers
      module Students
        class Roster

          def initialize(file)
            open_file = File.open(file.data_file.path)
            @book = Roo::Spreadsheet.open open_file
          end

          def start
            @book.sheet.each(id: 'ID') do |row|
              puts row
              process_row(row)
            end
          end

          private

          def get_info
            @book.sheet('info')
          end

          def student_exists?(row)
            Gaku::Student.exists?(student_foreign_id_number: row[:idnum].to_i.to_s)
          end

          def update_student(row)
          end

          def register_student(row)
            ActiveRecord::Base.transaction do
            end
          end

          def process_row(row)
            if student_exists?(row)
              update_student(row)
            else
              register_student(row)
            end
          end

        end
      end
    end
  end
end