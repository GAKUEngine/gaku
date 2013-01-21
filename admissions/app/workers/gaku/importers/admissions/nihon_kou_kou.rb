# -*- encoding: utf-8 -*-
module Gaku
  module Importers
    module Admissions
      class NihonKouKou
        include Sidekiq::Worker
        include SheetHelper
        require 'spreadsheet'
        require 'roo'

        def perform(sheet)
          logger.info("VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVopened")
        end

      end
    end
  end
end
