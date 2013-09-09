# -*- encoding: utf-8 -*-
require 'roo'
require 'GenSheet'

module Gaku
  module Exporters
    class RosterExporter
      @format
      @template
      @workbook

      def initialize(options = {})
        @format = options[:format] || '.xls'
        #TODO fix with paperclip
        @template = options[:template] || 'assets/templates/roster.xls'
        load_template(@template)
      end

      def load_template(template)
        begin
          @workbook = Roo::Spreadsheet.open(@template)
        rescue
          @workbook = Roo::Spreadsheet.new
        end
      end

      def export_all

      end

      def export(records = {})
      end
    end
  end

end
