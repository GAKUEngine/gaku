# -*- encoding: utf-8 -*-
module Gaku
  module Admin
    module Admissions
      class ImporterController < GakuController
        include SheetHelper
        #include Gaku::Admissions::Importers

        def index
          importers = Gaku::Admissions::Importers::AdmissionsImporters.new()

          @importer_types = importers.get_types
          render "gaku/admin/admissions/importer/index"
        end

        def get_template
        end

        def import_sheet
          if params[:importer][:data_file].nil?
            redirect_to importer_index_path, :alert => 'no file or bad file'
          else
            file = ImportFile.create(params[:importer].merge(:context => 'admissions'))
            importers = Gaku::Admissions::Importers::AdmissionsImporters.new()
            importers.run_importer(params[:importer][:importer_type], file, params[:importer][:data_file].content_type)
          end

          render :text => "working"
        end
      end
    end
  end
end
