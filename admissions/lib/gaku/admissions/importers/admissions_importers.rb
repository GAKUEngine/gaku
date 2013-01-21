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
            {:name => "高校志願者シート", :importer_function => 高校志願者シート }
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
          #if file_type == 'application/vnd.ms-excel'
          #admission_importer_types.each do |importer|
          #  if importer["name"] == importer_name
          #    importer.import_function
          #    return
          #  end
          #end
          #
          if file
            book = Spreadsheet.open(file.data_file.path)
            Gaku::Importers::Admissions::NihonKouKou.perform_async(book)
          end
        end
        
        def 高校志願者シート
          #Gaku::Importers::Admissions::NihonKouKou.perform_async(book)
        end
      end
    end
  end
end
