# -*- encoding: utf-8 -*-
require 'roo'
require 'GenSheet'

module Gaku
  module Core
    module Importers
      module Students
        class Roster

          #gets workbook info from 'info' sheet
          def get_info(book)
            info_sheet = book.sheet('info')
            return nil if info_sheet.nil?

          end

          end
          def self.import(file)
            raise "NO FILE" if file.data_file.nil?
            @book = Roo::Spreadsheet.open(file.data_file.path)
            info = get_info(@book)
            sheet = @book.sheet(info[:roster]) || @book.sheet.first || return

            Gaku::Core::Importers::Students::RosterWorker.perform_async(sheet)
          end
        end
      end
    end
  end
end
