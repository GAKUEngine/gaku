# -*- encoding: utf-8 -*-
module Gaku
  module Core
    module Importers
      module SchoolStation
        class Zaikousei
          
          @record_count

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
           # results[:record_count] = @record_count

           # logger.info "--------------------------------------------------"
           # logger.info "Created #{importer.record_count} student records in the db"
           # logger.info "Students in the db: #{Student.count}"
           # logger.info "Contacts in the db: #{Contact.count}"
           # logger.info "Addresses in the db: #{Address.count}"
           # logger.info "Guardians in the db: #{Guardian.count}"

            return results
          end

          def process_records(sheet)
            #get default index, then check for index on first row
            idx = get_default_index

            #sheet is shifted so the top line is taken
            #idx = check_index(sheet.first, idx)
            
            #sheet.each 1 do |row|
            #  Gaku::Importers::SchoolStation::ZaikouWorker.perform_async(row, idx)
            #end
            Gaku::Importers::SchoolStation::ZaikouWorker.perform_async(sheet, idx)
          end
        end
      end
    end
  end
end