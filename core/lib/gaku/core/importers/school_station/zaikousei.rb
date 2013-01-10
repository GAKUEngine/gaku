# -*- encoding: utf-8 -*-
module Gaku
  module Core
    module Importers
      module SchoolStation
        class Zaikousei
          
          @record_count
          @logger
          @loginfo

          def set_logger(logger)
            @logger = logger
          end

          def info(msg)
            if @logger.nil?
              @loginfo << msg << "\n"
            else
              @logger.info(msg)
            end
          end

          def get_default_index
            @record_count = 0
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

            return idx
          end

          #在校テーブルのフィルド順を確認し、表陣と違った場合インデックスを変更し返す
          def check_index(row, idx)
            row.each_with_index do |cell, i|
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

          def process_records(sheet)
            @loginfo = ""
            ActiveRecord::Base.transaction do

              #SchoolStationで大半の住所が日本にある
              country = Country.find_by_numcode(392)
              contact_type = ContactType.find_by_name("Phone")

              #get default index, then check for index on first row
              idx = get_default_index

              #sheet is shifted so the top line is taken
              idx = check_index(sheet.first, idx)
              sheet.each 1 do |row|
                if row[idx[:name]].nil?
                  next
                end

                if Gaku::Student.exists?(:student_foreign_id_number => row[idx[:foreign_id_number]].to_i.to_s)
                  info "Student with foreign_id: #{row[idx[:foreign_id_number]]} already exists"
                  next
                end

                @record_count += 1

                name_parts = row[idx[:name]].to_s().sub("　", " ").split(" ")
                surname = name_parts.first
                name = name_parts.last

                name_reading_parts = row[idx[:name_reading]].to_s().sub("　", " ").split(" ")
                surname_reading = name_reading_parts.first
                name_reading = name_reading_parts.last

                if row[idx[:birth_date]]
                  birth_date = Date.parse(row[idx[:birth_date]].to_s)
                  if birth_date.nil?
                    birth_date = Date.strptime(row[idx[:birth_date]].to_s, "%Y/%m/%d")
                  end
                end

                if row[idx[:gender]]
                  if row[idx[:gender]].to_i == 2
                    gender = 0
                  else
                    gender = 1
                  end
                end

                # check for existing
                student = Student.create!(:surname => surname,
                                :name => name,
                                :surname_reading => surname_reading,
                                :name_reading => name_reading,
                                :student_foreign_id_number => row[idx[:foreign_id_number]],
                                :birth_date => birth_date,
                                :gender => gender,
                                :admitted => 1)

                if student
                  info "--------------------------------------------------\n"
                  info "Created student: #{student.id}, name: #{student.name}\n"
                else
                  next
                end

                # add student address
                if row[idx[:city]] and row[idx[:address1]]

                  if row[idx[:state]]
                    state = State.where(:country_numcode => 392, :code => row[idx[:state]].to_i).first
                  end

                  #student_address = student.addresses.create!(:zipcode => row[idx[:zipcode]],
                  #                          :country_id => country.id,
                  #                          :state => state,
                  #                          :state_id => state.id,
                  #                          :state_name => state.name,
                  #                          :city => row[idx[:city]],
                  #                          :address1 => row[idx[:address1]],
                  #                          :address2 => row[idx[:address2]])
                  #if student_address
                  #  info "Created address: #{student_address.id} for student: #{student.id}"
                  #end
                end

                if row[idx[:phone]]
                  student_contact = student.contacts.create!(:contact_type_id => contact_type.id,
                                                             :is_primary => true,
                                                             :is_emergency => true,
                                                             :data => row[idx[:phone]])
                  if student_contact
                    info "Created contact: #{student_contact.id} for student: #{student.id}"
                  end

                end

                # add primary guardian
                if row[idx[:guardian][:name]]
                  guardian_name_parts = row[idx[:guardian][:name]].to_s().split("　")
                  guardian_surname = guardian_name_parts.first
                  guardian_name = guardian_name_parts.last


                  if row[idx[:guardian][:name_reading]]
                    guardian_name_reading_parts = row[idx[:guardian][:name_reading]].to_s().split(" ")
                    guardian_surname_reading = guardian_name_reading_parts.first
                    guardian_name_reading = guardian_name_reading_parts.last
                  end

                  guardian = student.guardians.create!(:surname => guardian_surname,
                                                      :name => guardian_name,
                                                      :surname_reading => guardian_surname_reading,
                                                      :name_reading => guardian_name_reading)

                  if guardian
                    info "Created guardian: #{guardian.id} for student: #{student.id}"
                  end

                  if row[idx[:guardian][:city]] and row[idx[:guardian][:address1]]

                    state = State.where(:country_numcode => 392, :code => row[idx[:guardian][:state]].to_i).first



                    guardian_address = guardian.addresses.create!(:zipcode => row[idx[:guardian][:zipcode]],
                                            :country_id => country.id,
                                            :state => state,
                                            :state_id => state.id,
                                            :state_name => state.name,
                                            :city => row[idx[:guardian][:city]],
                                            :address1 => row[idx[:guardian][:address1]],
                                            :address2 => row[idx[:guardian][:address2]])
                    if guardian_address
                      info "Created address: #{guardian_address.id} for guardian: #{guardian.id}"
                    end

                  end

                  if row[idx[:guardian][:phone]]
                      contact = Gaku::Contact.new()
                      contact.contact_type = contact_type
                      contact.is_primary = true
                      contact.is_emergency = true
                      contact.data = row[idx[:guardian][:phone]]
                      contact.save

                      guardian.contacts << contact
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
