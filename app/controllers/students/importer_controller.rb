class Students::ImporterController < ApplicationController
  include SheetHelper
  require 'spreadsheet'
  require 'roo'

  def index
    @importer_types = ["GAKU Engine", "SchoolStation"]
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
    # import_sheet_student_list

    if params[:importer][:data_file].nil?
      redirect_to importer_index_path, :alert => 'no file or bad file' 
    else
      if params[:importer][:data_file].content_type == 'application/vnd.ms-excel'
        case params[:importer][:importer_type]
        when "GAKU Engine"
          import_sheet_student_list()

        when "SchoolStation"
          import_school_station_student_list()
        end

      elsif params[:importer][:data_file].content_type == "text/csv"
          import_csv_student_list()
      end
    end
  end

  def import_csv_student_list
    @rowcount = 0
    @csv_data = nil
    @status = "OPENING_FILE"
    @csv_data = params[:importer][:data_file].read.force_encoding("UTF-8")
    CSV.parse(@csv_data) do |row|
      case @rowcount
      when 0 #field index
        #get mapping
        #TODO
      when 1 #titles
        #ignore
      else #process record
        Student.create!(:surname => row[0], :name => row[1], :surname_reading => row[2], :name_reading => row[3])
      end
      @rowcount += 1
    end
    render :student_import_preview
  end

  def import_sheet_student_list

    file_data = params[:importer][:data_file]
    
    #read from saved file
    importer = ImportFile.new(params[:importer])
    importer.context = 'students'
    if importer.save
      book = Spreadsheet.open(importer.data_file.path)
      
      #read from not saved file. just read file
      # book = Spreadsheet.open(file_data.path)
      
      sheet = book.worksheet(0)

      ActiveRecord::Base.transaction do
      #Giorgio:put in transaction for fast importing
        sheet.each do |row|
          unless book.worksheet('Sheet1').first == row 
            # check for existing
            student = Student.create!(:surname => row[0], 
                            :name => row[1], 
                            :surname_reading => row[2], 
                            :name_reading => row[3])
          end
        end
      end
      redirect_to importer_index_path, :notice => 'Spreadsheet Successful Imported'
    else
        redirect_to :back
    end

  end

  #import XLS list exported from SchoolStation
  #在校生リストを先にインポートする必要がある
  def import_school_station_student_list
    #import ZAIKOU list from SchoolStation
    @rowcount = nil
    @sheet_data = nil

    @status = "OPENING_FILE"
    @sheet_data = params[:import_student_list][:data_file].read
    @workbook = Spreadsheet::ParseExcel.parse(@sheet_data)
    #@worksheet = @workbook.work

    #collect fields
    
    #在校テーブルか生徒情報テーブルの情報を区別する
    

    render :importer_school_station_preview
  end

end
