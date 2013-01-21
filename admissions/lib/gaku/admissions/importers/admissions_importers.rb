# -*- encoding: utf-8 -*-
module Gaku
  module Admissions
    module Importers
      class AdmissionsImporters
        include SheetHelper
        require 'spreadsheet'
        require 'roo'

        def admission_importer_types
          [
            {:name => "高校志願者シート", :importer_function => :高校志願者シート }
          ]
        end

        def get_types
          types = []
          admission_importer_types.each do |importer|
            types.push importer[:name]
          end

          return types
        end

        def run_importer(importer_name, file, file_type)
          admission_importer_types.each do |importer|
            if importer[:name] == importer_name
              book = Spreadsheet.open(file.data_file.path)
              send(importer[:importer_function], book)
              return
            end
          end
        end
        
        def 高校志願者シート(book)
          #Gaku::Importers::Admissions::NihonKouKou.perform_async(book)
          sheet = book.worksheet('入力推普')
          Gaku::Importers::Admissions::NihonKouKou.perform_async(sheet)
        end
      end
    end
  end
end
