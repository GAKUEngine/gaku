# -*- encoding: utf-8 -*-
module Gaku
  module Admin
    class ApplicantImporterController < GakuController
      @importer_types = ["学園陣用日本高校標準"]
      def import_applicant_list
        if params[:importer][:data_file].nil?
          redirect_to importer_index_path, :alert => 'no file or bad file'
        else
          case params[:importer][:importer_type]
          when "学園陣用日本高校標準"
            import_gaku_engine_ja_highschool(params[:importer][:data_file])
          end
        end
      end

      def import_gaku_engine_ja_highschool(datafile)
        if datafile.content_type == 'application/vnd.ms-excel'
        elsif datafile.content_type == "text/csv"
        end
      end
    end
  end
end
