# -*- encoding: utf-8 -*-
require 'roo'
require 'GenSheet'

module Gaku
  module Core
    module Exporters
      class RosterExporter
        @format
        @template
        @workbook

        def initialize(options = {})
          @format = options[:format] || '.xls'
          @template = options[:template] || 'app/templates/core/roster'
          load_template(@template)
        end

        def load_template(template)
          @workbook = Roo::Spreadsheet.open(@template)
          puts 'template loaded'
        end

        def export_all()

        end

        def export(records = {})
        end
      end
    end
  end
end
