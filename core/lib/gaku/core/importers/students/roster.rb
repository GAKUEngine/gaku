# -*- encoding: utf-8 -*-
require 'roo'
require 'GenSheet'

module Gaku
  module Core
    module Importers
      module Students
        class Roster


          # end
          def self.import(file)
            raise "NO FILE" if file.data_file.nil?
            # @book = Roo::Spreadsheet.open(file.data_file.path)
            # info = self.get_info(@book)
            # raise info.inspect
            # sheet = @book.sheet(info[:roster]) || @book.sheet.first || return

            Gaku::Core::Importers::Students::RosterWorker.perform_async('opa')
          end
          #gets workbook info from 'info' sheet
          def self.get_info(book)
            # info_sheet = book.sheet('info')
            # raise book.cell(1,1).inspect
            # return nil if info_sheet.nil?

          end
        end
      end
    end
  end
end
