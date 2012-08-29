# -*- encoding: utf-8 -*-

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
        @rowcount = 0

        #initial default values (from inital raw output)
        nameIdx = 7
        nameReadingIdx = 8
        birthDateIdx = 10
        genderIdx = 11
        phoneIdx = 19

        #primary address
        zipcodeIdx = 14
        stateIdx = 15
        cityIdx = 16
        address1Idx = 17
        address2Idx = 18

        #primary guardian
        guardianNameIdx = 34
        guardianNameReadingIdx = 35
        guardianZipCodeIdx = 37
        guardianStateIdx = 38
        guardianCityIdx = 39
        guardianAddress1Idx = 40
        guardianAddress2Idx = 41
        guardianPhoneIdx = 42

        sheet.each do |row|
          unless book.worksheet('CAMPUS_ZAIKOTBL').first == row
            if row[nameIdx].nil?
              next
            end

            @rowcount += 1

            nameParts = row[nameIdx].to_s().split("　")
            surname = nameParts.first
            name = nameParts.last
            nameReadingParts = row[nameReadingIdx].to_s().split(" ")
            surname_reading = nameReadingParts.first
            name_reading = nameReadingParts.last
            puts "parsing date: " << row[birthDateIdx].to_s
            birth_date = Date.parse(row[birthDateIdx].to_s)
            gender = nil
            if !row[genderIdx].nil?
              if row[genderIdx].to_i == 2
                gender = 0
              else
                gender = 1
              end
            end
            phone = row[phoneIdx]

            # check for existing
            student = Student.create!(:surname => surname, 
                            :name => name, 
                            :surname_reading => surname_reading, 
                            :name_reading => name_reading,
                            :birth_date => birth_date,
                            :gender => gender,
                            :phone => phone)

            if student.nil?
              #TODO no student was created
              next
            end

            zipcode = row[zipcodeIdx]
            state = row[stateIdx]
            city = row[cityIdx]
            address1 = address1Idx
            address2 = address2Idx
            student.addresses.create!(:zipcode => zipcode,
                                      :state => state,
                                      :city => city,
                                      :address1 => address1,
                                      :address2 => address2)

          else #1st row, try parsing index
            row.each_with_index do |cell, i|
              case cell
              when "ZAINAM_C" #生徒名の漢字
                nameIdx = i
              when "ZAINAM_K"
                nameReadingIdx = i
              when "ZAIBTHDY"
                birthDateIdx = i
              when "ZAISEXKN"
                genderIdx = i
              when "ZAIZIPCD"
                zipcodeIdx = i
              when "ZAIADRCD"
                stateIdx = i
              when "ZAIADR_1"
                cityIdx = i
              when "ZAIADR_2"
                address1Idx = i
              when "ZAIADR_3"
                address2Idx = i
              when "ZAITELNO"
                phoneIdx = i
              when "HOGNAM_C"
                guardianNameIdx = i
              when "HOGNAM_K"
                guardianNameReadingIdx = i
              when "HOGZIPCD"
                guardianZipCodeIdx = i
              when "HOGADR_1"
                guardianCityIdx = i
              when "HOGADR_2"
                guardianAddress1Idx = i
              when "HOGADR_3"
                guardianAddress2Idx = i
              when "HOGTELNO"
                guardianPhoneIdx = i
              end
            end
          end
        end
      end
    end
    #@worksheet = @workbook.work

    #collect fields
    
    #在校テーブルか生徒情報テーブルの情報を区別する
    

    render :importer_school_station_preview
  end

end
