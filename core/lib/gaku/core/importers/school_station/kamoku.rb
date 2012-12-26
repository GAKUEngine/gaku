# -*- encoding: utf-8 -*-
module Gaku
  module Core
    module Importers
      class SchoolStation
        class Kamoku
          # default filename CAMPUS_KAMOKTBL
          def import(data)
            #import ZAIKOU list from SchoolStation
            #file_data = data[:data_file]
            
            #read from saved file
            importer = ImportFile.new(data)
            importer.context = 'students'
            if importer.save
              book = Spreadsheet.open(importer.data_file.path)
              
              sheet = book.worksheet(0)

              ActiveRecord::Base.transaction do
                #Giorgio:put in transaction for fast importing
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
            idx = Hash.new

            #initial default values (from inital raw output)
            idx[:subject_code] = 5
            idx[:category_code] = 6
            idx[:name] = 7
            idx[:code] = 8

            return idx
          end

          def check_index(row, idx)
            row.each_with_index do |cell, i|
              case cell
              when "SUBJCTCD"
                idx[:subject_code] = i
              when "CATGRYCD"
                idx[:category_code] = i
              when "KAMNAM_C"
                idx[:name] = i
              when "KAMNAM_R"
                idx[:code] = i
              end
            end

            return idx
          end
        end
      end
    end
  end
end
