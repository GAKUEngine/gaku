# -*- encoding: utf-8 -*-
require 'roo'
require 'GenSheet'

module Gaku
  module Core
    module Importers
      module Students
        class Roster
          def self.import(file)
            raise "NO FILE" if file.data_file.nil?

            @book = Roo::Spreadsheet.open(file.data_file.path)
            
          end
        end
      end
    end
  end
end
