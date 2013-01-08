# -*- encoding: utf-8 -*-
module Gaku
  module Core
    module Importers
      module SchoolStation

        class Zaikousei
          
          def get_default_index
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
              end
            end

            return idx
          end


        end
      end
    end
  end
end
