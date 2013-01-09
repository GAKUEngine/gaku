# -*- encoding: utf-8 -*-
module Gaku
  module Core
    module Importers
      module SchoolStation
        class Seito
          
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
            idx[:foreign_id_number] = 4


            idx[:course_code] = 8
            idx[:gakunen] = 9
            idx[:kumi] = 10
            idx[:seat_number] = 11
            idx[:nyuugakunen] = 12

            return idx
          end

          #在校テーブルのフィルド順を確認し、表陣と違った場合インデックスを変更し返す
          def check_index(row, idx)
            row.each_with_index do |cell, i|
              case cell
              when "SEITONUM"
                idx[:foreign_id_number] = i
              when "STUCRSCD"
                idx[:course_code] = i
              when "STUGKNEN"
                idx[:gakunen] = i
              when "STUKUMI"
                idx[:kumi] = i
              when "STUSYUNO"
                idx[:seat_number] = i
              end
            end

            return idx
          end

          def process_records(sheet)
            @loginfo = ""
            ActiveRecord::Base.transaction do

            end
          end
        end
      end
    end
  end
end
