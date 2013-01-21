# -*- encoding: utf-8 -*-
module Gaku
  module Importers
    module Admissions
      class NihonKouKou
        include Sidekiq::Worker
        include SheetHelper
        require 'spreadsheet'
        require 'roo'

        def perform(book)
          #sheet = book.worksheet('入力推普')
          logger.info("opened")
        end

      end
    end
  end
end
