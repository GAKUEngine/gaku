# -*- encoding: utf-8 -*-
require 'roo'
require 'GenSheet'

module Gaku
  module Core
    module Importers
      module Students
        class Roster
          def initialize(file)
            open_file = File.open file.data_file.path
            @book = Roo::Spreadsheet.open open_file
            get_info
            open_roster
            start
          end

          def open_roster
            I18n.locale = @info['lang'] || I18n.default_locale
            @book.sheet(I18n.t('student.roster'))
          end

          def start
            @book.sheet.drop(@info['header_height'].to_i).each(id: t(:id),
              name: t(:name), name_reading: t(:name_reading),
              middle_name: t(:middle_name),
              middle_name_reading: t(:middle_name_reading),
              surname: t(:surname), surname_reading: t(:surname_reading)
                ) do |row|
              puts row
              process_row(row)
            end
          end

          private

          def get_info
            @book.sheet('info')
            @info = @book.parse(locale: 'locale', template_ver: 'template_ver',
              export_date: 'export_date', header_height: 'header_height',
              index_row: 'index_row')
          end

          def student_exists?(row)
            Gaku::Student.exists?(
              student_foreign_id_number: row[:idnum].to_i.to_s)
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
