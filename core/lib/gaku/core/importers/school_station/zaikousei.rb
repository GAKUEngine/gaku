# -*- encoding: utf-8 -*-
module Gaku
  module Core
    module Importers
      module SchoolStation
        class Zaikousei
<<<<<<< HEAD
          
          def get_default_index
=======
          # default filename CAMPUS_ZAIKOTBL
          def import(id)

            importer = ImportFile.find(id)

            if importer
              book = Spreadsheet.open(importer.data_file.path)

              sheet = book.worksheet(0)

              ActiveRecord::Base.transaction do
                @record_count = 0

                idx = self.class.get_default_index()

                #定数
                @japanID = Country.where(:numcode => 392).first.id
                @phoneContactType = Gaku::ContactType.where(:name => "Phone").first


                sheet.each do |row|
                  unless book.worksheet('CAMPUS_ZAIKOTBL').first == row
                    if row[idx[:name]].nil?
                      next
                    end

                    student_foreign_id_number = nil
                    if !row[idx[:foreignIdNumber]].nil?
                      student_foreign_id_number = row[idx[:foreignIdNumber]].to_i.to_s
                    end

                    if Gaku::Student.exists?(:student_foreign_id_number => student_foreign_id_number)
                      next
                    end

                    @record_count += 1

                    nameParts = row[idx[:name]].to_s().sub("　", " ").split(" ")
                    surname = nameParts.first
                    name = nameParts.last
                    nameReadingParts = row[idx[:nameReading]].to_s().sub("　", " ").split(" ")
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
                    
                      student.addresses.create!(:zipcode => zipcode,
                                                :country_id => @japanID,
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

                      if !row[idx[:guardianZipCode]].nil? && !row[idx[:guardianState]].nil? && !row[idx[:guardianCity]].nil? && !row[idx[:guardianAddress1]].nil?
                        zipcode = row[idx[:guardianZipCode]]
                        state = State.where(:country_numcode => 392, :code => row[idx[:guardianState]].to_i).first
                        city = row[idx[:guardianCity]]
                        address1 = row[idx[:guardianAddress1]]

                        address2 = nil
                        if !row[idx[:guardianAddress2]].nil?
                          address2 = row[idx[:guardianAddress2]]
                        end

                        guardian.addresses.create!(:zipcode => zipcode,
                                                :country_id => @japanID,
                                                :state => state,
                                                :state_id => state.id,
                                                :state_name => state.name,
                                                :city => city,
                                                :address1 => address1,
                                                :address2 => address2)

                      end

                      if !row[idx[:guardianPhone]].nil?
                          contact = Gaku::Contact.new()
                          contact.contact_type = @phoneContactType
                          contact.is_primary = true
                          contact.is_emergency = true
                          contact.data = row[idx[:guardianPhone]]
                          contact.save

                          guardian.contacts << contact
                      end
                    end

                  else #1st row, try parsing index
                    idx = check_index(row, idx)
                  end
                end
              end
            end

            results = Hash.new
            results[:status] = "OK"
            results[:record_count] = @record_count


            return results
          end

          def self.get_default_index()
>>>>>>> Add some specs for zaikousei
            idx = Hash.new

            #initial default values (from inital raw output)
            idx[:name] = 7
            idx[:name_reading] = 8
            idx[:birth_date] = 10
            idx[:gender] = 11
            idx[:phone] = 19
            idx[:foreign_id_number] = 4

            #primary address
            idx[:zipcode] = 14
            idx[:state] = 15
            idx[:city] = 16
            idx[:address1] = 17
            idx[:address2] = 18

            #primary guardian
            idx[:guardian] = Hash.new
            idx[:guardian][:name] = 34
            idx[:guardian][:name_reading] = 35
            idx[:guardian][:zipcode] = 37
            idx[:guardian][:state] = 38
            idx[:guardian][:city] = 39
            idx[:guardian][:address1] = 40
            idx[:guardian][:address2] = 41
            idx[:guardian][:phone] = 42

            idx[:updated] = 2

            #add static fields
            #SchoolStationで大半の住所が日本にある
            idx[:country] = Country.find_by_numcode(392)
            idx[:contact_type] = ContactType.find_by_name("Phone")

            return idx
          end

          #在校テーブルのフィルド順を確認し、表陣と違った場合インデックスを変更し返す
          def check_index(row, idx)
            row.each_with_index do |cell, i|
              i = i.to_i
              case cell
              when "ZAINAM_C" #生徒名の漢字
                idx[:name] = i
              when "ZAINAM_K"
                idx[:name_reading] = i
              when "ZAIBTHDY"
                idx[:birth_date] = i
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
                idx[:guardian][:name] = i
              when "HOGNAM_K"
                idx[:guardian][:name_reading] = i
              when "HOGZIPCD"
                idx[:guardian][:zipcode] = i
              when "HOGADR_1"
                idx[:guardian][:city] = i
              when "HOGADR_2"
                idx[:guardian][:address1] = i
              when "HOGADR_3"
                idx[:guardian][:address2] = i
              when "HOGTELNO"
                idx[:guardian][:phone] = i
              when "SEITONUM"
                idx[:foreign_id_number] = i
              when "UPDATEDY"
                idx[:updated] = i
              end
            end

            return idx
          end

          def process_file(file)
            if file
              book = Spreadsheet.open(file.data_file.path)
              sheet = book.worksheet('CAMPUS_ZAIKOTBL')

              process_records(sheet)
            end

            results = Hash.new
            results[:status] = "OK"

            return results
          end

          def process_records(sheet)
            #get default index, then check for index on first row
            idx = get_default_index

            #sheet is shifted so the top line is taken
            #idx = check_index(sheet.first, idx)
            
            Gaku::Importers::SchoolStation::ZaikouWorker.perform_async(sheet, idx)
          end
        end
      end
    end
  end
end
