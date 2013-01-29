# -*- encoding: utf-8 -*-
module Gaku
  module Admin
    module Admissions
      class ImporterController < GakuController

        def index
          importers = Gaku::Admissions::Importers::AdmissionsImporters.new()

          @importer_types = importers.get_types

          @admission_period = AdmissionPeriod.find(params[:admission_period_id])
          if params[:admission_method_id]
            @admission_method = AdmissionMethod.find(params[:admission_method_id])
          else
            @admission_method = @admission_period.admission_methods.first
          end

          respond_to do |format|
            format.js
          end
          #render "gaku/admin/admissions/importer/index"
        end

        def get_template
        end

        def import_sheet
          if params[:importer][:data_file].nil?
            redirect_to importer_index_path, :alert => 'no file or bad file'
            return
          end

          file = ImportFile.create(params[:importer].merge(:context => 'admissions'))
          importers = Gaku::Admissions::Importers::AdmissionsImporters.new()
          importers.run_importer(params[:importer][:importer_type], file, 
                                 params[:importer][:data_file].content_type, params[:admission_period_id], params[:admission_method_id])

          render :text => "working dayo-"
        end
      end
    end
  end
end
