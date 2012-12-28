# -*- encoding: utf-8 -*-
module Gaku
  class Syllabuses::ImporterController < GakuController
    include SheetHelper
    require 'gaku/core/importers/school_station/kamoku.rb'
    require 'spreadsheet'
    require 'roo'

    def index
      @importer_types = ["GAKU Engine", "SchoolStation"]
      render "gaku/syllabuses/importer/index"
    end

    def get_template
    end

    def import_from_template
      case params[:importer][:data_type]
      when "SchoolStation"
        importer = Gaku::Core::Importers::SchoolStation::Kamoku.new()
        @results = importer.import(params[:importer][:data_file])
        render :text => "seems ok"
      end
    end

  end
end
