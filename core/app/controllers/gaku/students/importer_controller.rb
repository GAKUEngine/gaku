# -*- encoding: utf-8 -*-
module Gaku
  class Students::ImporterController < GakuController

    skip_authorization_check

    require 'roo'

    def index
      @importer_types = ['students.import_roster']
      render 'gaku/students/importer/index'
    end

    def get_roster
    end

    def import_student_roster
      if params[:importer][:data_file].nil?
        redirect_to importer_index_path, alert: 'no file or bad file'
      else
        if params[:importer][:data_file].content_type == 'application/vnd.ms-excel'
          case params[:importer][:importer_type]
          when "GAKU Engine"
            import_sheet_student_list
          when "SchoolStation"
            import_school_station_students_xls
          end

        elsif params[:importer][:data_file].content_type == "text/csv"
            import_csv_student_list
        end
      end
    end
  end
end
