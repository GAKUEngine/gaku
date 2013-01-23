# -*- encoding: utf-8 -*-
module Gaku
  module Importers
    module Admissions
      class NihonKouKou
        include Sidekiq::Worker
        include SheetHelper
        require 'spreadsheet'
        require 'roo'

        def get_index(sheet)
          sheet.drop(5)
          logger.info "INDEX?" + sheet[1].to_s
          return nil
        end

        def perform(entry_sheet)
          idx = get_index(entry_sheet)

          entry_sheet.drop(6).each do |row|
            process_row(row, idx)
          end
        end

        def process_row(row, idx)
          ActiveRecord::Base.transaction do
            logger.info row
          end
        end
      end
    end
  end
end
