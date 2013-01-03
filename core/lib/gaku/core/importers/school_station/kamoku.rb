# -*- encoding: utf-8 -*-
module Gaku
  module Core
    module Importers
      module SchoolStation
        class Kamoku
          @sheet_name = "CAMPUS_KAMOKTBL"
          def import(data)
            importer = ImportFile.new(data)

            importer.context = 'syllabuses'
            if importer.save
              book = Spreadsheet.open(data.path)
              sheet = book.worksheet(@sheet_name)

              ActiveRecord::Base.transaction do
                @record_count = 0

                idx = self.class.get_default_index()

                sheet.each do |row|
                  unless sheet.first == row
                    @record_count += 1

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
