# -*- encoding: utf-8 -*-
module Gaku
  module Importers
    module Admissions
      class NihonKouKou
        puts "NihonKouKou------------------------------"
        include Sidekiq::Worker
        include SheetHelper
        require 'roo'


        def perform(file_path, period_id, method_id)
          puts "perform------------------------------"
          #one liner open, relying on Roo to figure it out
          book = Roo::Spreadsheet.open(file_path)

          if book.nil?
            return
          end

          基本入力処理(book, period_id, method_id)
        end


        def 基本入力処理(book, period_id, method_id)
          puts "基本入力処理------------------------------"
          sheet = book.sheet('入力')

          idx = get_index_from_row(sheet.row(7))

          sheet.drop(7).each do |row|
            基本入力一行分(row, idx, period_id, method_id)
          end
        end


        def 基本入力一行分(row, idx, period_id, method_id)
          ActiveRecord::Base.transaction do
            name_raw = row[idx["氏名"]]
            puts "name_raw---------------------------------------------"
            puts name_raw
            if name_raw.nil?
              #名前が無い行の情報を無視
              return
            end

            name_parts = name_raw.sub("　", " ").split(" ")
            surname = name_parts.first
            name = name_parts.last

            name_reading_raw = row[idx["フリガナ"]]

            surname_reading = ""
            name_reading = ""
            if !name_reading_raw.nil?
              name_reading_parts = name_reading_raw.to_s().sub("　", " ").split(" ")
              surname_reading = name_reading_parts.first
              name_reading = name_reading_parts.last
            end

            applicant_number = row[idx["受験番号"]]

            if !applicant_number.nil? && !period_id.nil? && !method_id.nil?
              duplicates = Admission.where(:applicant_number => applicant_number, :admission_period_id => period_id, :admission_method_id => method_id)
              if duplicates.length > 0
                logger.info "志願者#" + applicant_number + "「" + surname + "　" + name + "」が既に" + AdmissionPeriod.find(period_id).name + ":" + AdmissionMethod.find(method_id).name
                return
              end
            end

            #TODO check for existing
            student = Student.create!(:surname => surname,
                            :name => name,
                            :surname_reading => surname_reading,
                            :name_reading => name_reading,
                            :enrollment_status_id => Gaku::EnrollmentStatus.find_by_code("applicant").id)

            if !period_id.nil? && !method_id.nil?
              admission = Admission.new(:student_id => student.id, :applicant_number => applicant_number, :admission_period_id => period_id, :admission_method_id => method_id)
              logger.info
              if admission.save
                admission_method = admission.admission_method
                admission_period = AdmissionPeriod.find(period_id)
                admission_phase = admission_method.admission_phases.first
                admission_phase_state = admission_phase.admission_phase_states.first
                admission_phase_record = AdmissionPhaseRecord.create(
                                                      :admission_phase_id => admission_phase.id,
                                                      :admission_phase_state_id => admission_phase_state.id,
                                                      :admission_id => admission.id)
                
                admission.student.update_column(:enrollment_status_id, Gaku::EnrollmentStatus.where(code:"applicant").first.id)
              end
              logger.info "志願者「" + surname + "　" + name + 
                "[" + surname_reading + "　" + name_reading + "]」を登録しました。"
            else
              logger.info "入学時期及び入学形態が設定されていなかった為志願者" + "「" + surname + "　" + name +
                "[" + surname_reading + "　" + name_reading + "]」を入学時期形態なしで志願者リストに登録しました。"
            end
          end
        end


      end
    end
  end
end
