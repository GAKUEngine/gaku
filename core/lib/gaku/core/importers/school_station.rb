# -*- encoding: utf-8 -*-
module Importers
  class SchoolStationImporter
    def import_zaikousei(data)
      #import ZAIKOU list from SchoolStation
      #file_data = data[:data_file]
      
      #read from saved file
      importer = ImportFile.new(data)
      importer.context = 'students'
      if importer.save
        book = Spreadsheet.open(importer.data_file.path)
        
        #read from not saved file. just read file
        # book = Spreadsheet.open(file_data.path)
        
        sheet = book.worksheet(0)

        ActiveRecord::Base.transaction do
          #Giorgio:put in transaction for fast importing
          @record_count = 0
        
          idx = self.class.get_default_zaikou_index()

          sheet.each do |row|
            unless book.worksheet('CAMPUS_ZAIKOTBL').first == row
              if row[idx[:name]].nil?
                next
              end

              @record_count += 1

              nameParts = row[idx[:name]].to_s().split("　")
              surname = nameParts.first
              name = nameParts.last
              nameReadingParts = row[idx[:nameReading]].to_s().split(" ")
              surname_reading = nameReadingParts.first
              name_reading = nameReadingParts.last
              birth_date = nil
              if !row[idx[:birthDate]].nil?
                birth_date = Date.parse(row[idx[:birthDate]].to_s)
                if birth_date.nil?
                  birth_date = Date.strptime(row[idx[:birthDate]].to_s, "%Y/%m/%d")
                end
              end
              
              gender = nil
              if !row[idx[:gender]].nil?
                if row[idx[:gender]].to_i == 2
                  gender = 0
                else
                  gender = 1
                end
              end
              
              phone = nil
              if !row[idx[:phone]].nil?
                phone = row[idx[:phone]]
              end

              student_foreign_id_number = nil
              if !row[idx[:foreignIdNumber]].nil?
                student_foreign_id_number = row[idx[:foreignIdNumber]]
              end

              # check for existing
              student = Student.create!(:surname => surname, 
                              :name => name,
                              :surname_reading => surname_reading, 
                              :name_reading => name_reading,
                              :student_foreign_id_number => student_foreign_id_number,
                              :birth_date => birth_date,
                              :gender => gender,
                              :phone => phone)

              if student.nil?
                #TODO no student was created
                next
              end

              # add primary address
              zipcode = nil
              if !row[idx[:zipcode]].nil?
                zipcode = row[idx[:zipcode]]
              end
              state = nil
              if !row[idx[:state]].nil?
                state = State.where(:country_numcode => 392, :code => row[idx[:state]].to_i).first
              end
              city = nil
              if !row[idx[:city]].nil?
                city = row[idx[:city]]
              end
              address1 = nil
              if !row[idx[:address1]].nil?
                address1 = row[idx[:address1]]
              end
              address2 = nil

              if !row[idx[:address2]].nil?
                address2 = row[idx[:address2]]
              end

              if !city.nil? && !address1.nil?
                student.addresses.create!(:zipcode => zipcode,
                                          :country_id => Country.where(:numcode => 392).first.id,
                                          :state => state,
                                          :state_id => state.id,
                                          :state_name => state.name,
                                          :city => city,
                                          :address1 => address1,
                                          :address2 => address2)
              end

              # add primary guardian
              if !row[idx[:guardianName]].nil?
                guardianNameParts = row[idx[:guardianName]].to_s().split("　")
                guardianSurname = guardianNameParts.first
                guardianName = guardianNameParts.last

                guardianSurname_reading = nil
                guardianName_reading = nil
                if !row[idx[:guardianNameReading]].nil?
                  guardianNameReadingParts = row[idx[:guardianNameReading]].to_s().split(" ")
                  guardianSurname_reading = guardianNameReadingParts.first
                  guardianName_reading = guardianNameReadingParts.last
                end

                guardian = student.guardians.create!(:surname => guardianSurname,
                                                    :name => guardianName,
                                                    :surname_reading => guardianSurname_reading,
                                                    :name_reading => guardianName_reading)
              end

            else #1st row, try parsing index
              idx = check_zaikou_index(row, idx)
            end
          end
        end
      end

      results = Hash.new
      results[:status] = "OK"
      results[:record_count] = @record_count


      return results
    end

    def self.get_default_zaikou_index()
      idx = Hash.new

      #initial default values (from inital raw output)
      idx[:name] = 7
      idx[:nameReading] = 8
      idx[:birthDate] = 10
      idx[:gender] = 11
      idx[:phone] = 19
      idx[:foreignIdNumber] = 4

      #primary address
      idx[:zipcode] = 14
      idx[:state] = 15
      idx[:city] = 16
      idx[:address1] = 17
      idx[:address2] = 18

      #primary guardian
      idx[:guardianName] = 34
      idx[:guardianNameReading] = 35
      idx[:guardianZipCode] = 37
      idx[:guardianState] = 38
      idx[:guardianCity] = 39
      idx[:guardianAddress1] = 40
      idx[:guardianAddress2] = 41
      idx[:guardianPhone] = 42

      return idx
    end

    #在校テーブルのフィルド順を確認し、表陣と違った場合インデックスを変更し返す
    def check_zaikou_index(row, idx)
      row.each_with_index do |cell, i|
        case cell
        when "ZAINAM_C" #生徒名の漢字
          idx[:name] = i
        when "ZAINAM_K"
          idx[:nameReading] = i
        when "ZAIBTHDY"
          idx[:birthDate] = i
        when "ZAISEXKN"
          idx[:gender] = i
        when "ZAIZIPCD"
          idx[:zipcode] = i
        when "ZAIADRCD"
          idx[:state] = i
        when "ZAIADR_1"
          idx[:city] = i
        when "ZAIADR_2"
          idx[:address1] = i
        when "ZAIADR_3"
          idx[:address2] = i
        when "ZAITELNO"
          idx[:phone] = i
        when "HOGNAM_C"
          idx[:guardianName] = i
        when "HOGNAM_K"
          idx[:guardianNameReading] = i
        when "HOGZIPCD"
          idx[:guardianZipCode] = i
        when "HOGADR_1"
          idx[:guardianCity] = i
        when "HOGADR_2"
          idx[:guardianAddress1] = i
        when "HOGADR_3"
          idx[:guardianAddress2] = i
        when "HOGTELNO"
          idx[:guardianPhone] = i
        when "SEITONUM"
          idx[:foreignIdNumber] = i
        end
      end

      return idx
    end
  end
end
