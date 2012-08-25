class Students::ImporterController < ApplicationController
  include SheetHelper
  require 'iconv'

  def index
    @importer_types = ["Native", "SchoolStation"]
    render "students/importer/index"
  end

  def get_csv_template
    filename = "StudentRegistration.csv"
    registration_fields = ["surname", "name", "surname_reading", "name_reading", "gender", "phone", "email", "birth_date", "admitted"]
    content = CSV.generate do |csv|
      csv << registration_fields
      csv << translate_fields(registration_fields)
    end
    send_data content, :filename => filename
  end

  def get_sheet_template
  end


  def import_student_list
    @rowcount = 0
    @csv_data = nil
    @status = "NO_FILE"
    if params[:import_student_list][:file] != nil
      @status = "FILE_FOUND"
      @csv_data = params[:import_student_list][:file].read.force_encoding("UTF-8")
      CSV.parse(@csv_data) do |row|
        case @rowcount
        when 0 #field index
          #get mapping
        when 1 #titles
          #ignore
        else #process record
          Student.create!(:surname => row[0], :name => row[1], :surname_reading => row[2], :name_reading => row[3])
        end
        @rowcount += 1
      end
    end
    render :student_import_preview
  end

  #import a student list from a CSV or Sheet from a different system
  def import_non_native_student_list
    #get system type
    #TODO

    #import basic list from SchoolStation
    @rowcount = nil
    @sheet_data = nil
    @status = "NO_FILE"

    if params[:import_student_list][:file] != nil
      @status = "FILE_FOUND"
      @sheet_data = params[:import_student_list][:file].read
      @workbook = Spreadsheet.open(@sheet_data)
      @worksheet = @workbook.work
    end

    #collect fields
    
    #在校テーブルか生徒情報テーブルの情報を区別する
  end

end
