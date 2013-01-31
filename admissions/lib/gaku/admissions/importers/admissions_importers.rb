# -*- encoding: utf-8 -*-
module Gaku
  module Admissions
    module Importers
      class AdmissionsImporters
        include SheetHelper
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

        def run_importer(importer_name, file, content_type, period_id, method_id)
          puts "run_importer--------------------"
          admission_importer_types.each do |importer|
            if importer[:name] == importer_name
              send(importer[:importer_function], file, period_id, method_id)
              return
            end
          end
        end
        
        def 高校志願者シート(file, period_id, method_id)
          puts "高校志願者シート--------------------"
          Gaku::Importers::Admissions::NihonKouKou.perform_async(file.data_file.path, period_id, method_id)
        end
      end
    end
  end
end
