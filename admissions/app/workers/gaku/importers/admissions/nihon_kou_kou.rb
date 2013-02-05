# -*- encoding: utf-8 -*-
module Gaku
  module Importers
    module Admissions
      class NihonKouKou
        include Sidekiq::Worker
        include SheetHelper
        require 'roo'

        def perform(file_path, period_id, method_id)
          #one liner open, relying on Roo to figure it out
          book = Roo::Spreadsheet.open(file_path)

          if book.nil?
            logger.info "インポートファイルをシートとして開けませんでした。"
            return
          end

          基本入力処理(book, period_id, method_id)
        end


        def 基本入力処理(book, period_id, method_id)
          logger.info "--日本高校シートの基本入力シート処理開始--"
          sheet = book.sheet('入力')

          idx = get_index_from_row(sheet.row(7))

          sheet.drop(7).each do |row|
            基本入力一行分(row, idx, period_id, method_id)
          end
        end


        def 内申点登録(student, record, row, idx)
          kyoka9 = ["国","社","数","理","音","美","体","技","英"]
          kyoka5 = ["国","社","数","理","英"]
          kyoka3 = ["国","数","英"]

          logger.info "志願者「" + student.surname + "　" + student.name + "」の内申点を登録します。"

          def 内申点合計計算(kyoka_list, name, student, record, row, idx)
            total = 0
            
            kyoka_list.each do |kyoka|
              total += row[idx[kyoka]]
            end

            naishin = SimpleGrade.first_or_create(:student_id  => student.id, :name => name)
            naishin.grade = total
            naishin.save
            record.simple_grades << naishin
          end
          
          kyoka9.each do |kyoka|
            naishin = SimpleGrade.first_or_create(:student_id  => student.id, :name => kyoka)
            naishin.grade = row[idx[kyoka]]
            naishin.save
            logger.info "志願者「" + student.surname + "　" + student.name + "」に" + kyoka + "の点数" + naishin.grade.to_s + "を登録しました。"
            record.simple_grades << naishin
          end

          内申点合計計算(kyoka9, "９教科", student, record, row, idx)
          内申点合計計算(kyoka5, "５教科", student, record, row, idx)
          内申点合計計算(kyoka3, "３教科", student, record, row, idx)
        end

        def 中学校検索(code, name)
          school = School.where(:code => code).first
          if school.nil?
            school = School.where(:name => name).first
            if school.nil?
              logger.info "学校「" + name + "」[" + code + "]の登録が無かった為仮に作成しました。"
              school = School.create!(:code => code, :name => name)
            end
          end

          return school
        end

        def 中学校度の内容登録(student, row, idx)
          school = 中学校検索(row[idx["中学校コード"]], row[idx["中学校名"]])
          record = ExternalSchoolRecord.where(:student_id => student.id, :school_id => school.id).first
          if record.nil?
            logger.info "志願者「" + student.surname + "　" + student.name + "」の中学校情報「" + school.name + "[" + school.code + "]」を登録します。"
            record = ExternalSchoolRecord.new
            record.school = school
            record.data = ""
            record.student_id = student.id
            year_2_absences = row[idx["２年欠席"]].to_i
            year_3_absences = row[idx["３年欠席"]].to_i
            record.absences = year_2_absences + year_3_absences
            record.data << {:year_2_absences => year_2_absences, :year_3_absences => year_3_absences}.to_json
            record.save
            logger.info "志願者「" + student.surname + "　" + student.name + "」の中学情報を登録しました。"
          end

          内申点登録(student, record, row, idx)
        end

        def 志望学科登録(admission, row, idx)
          if !row[idx["１志望"]].nil? && row[idx["１志望"]] != ""
            logger.info "志願学科「" + row[idx["１志望"]] + "」を探してます。"
            specialty = Specialty.where(:name => row[idx["１志望"]]).first
            if !specialty.nil?
              application = SpecialtyApplication.create!(:admission_id => admission.id, :rank => 1,
                                               :specialty_id => specialty.id)
              if application.specialty_id != nil
                application.save
                admission.specialty_applications << application
                logger.info "志願者" + admission.student.surname + "　" + admission.student.name + "の第一志願が「" + application.specialty.name + "」です。"
              end
            else
              logger.info "学科/専攻「" + row[idx["１志望"]] + "」が見つかりませんでした。シートデータを直すか専攻を追加して"
            end
          end

          if !row[idx["２志望"]].nil? && row[idx["２志望"]] != ""
            specialty = Specialty.where(:name => row[idx["２志望"]]).first
            if !specialty.nil?
              application = SpecialtyApplication.create!(:admission_id => admission.id, :rank => 1,
                                               :specialty_id => specialty.id)
              if application.specialty_id != nil
                application.save
                admission.specialty_applications << application
                logger.info "志願者" + admission.student.surname + "　" + admission.student.name + "の第二志願が「" + application.specialty.name + "」です。"
              end
            else
              logger.info "学科/専攻「" + row[idx["２志望"]] + "」が見つかりませんでした。シートデータを直すか専攻を追加して"
            end
          end

          admission.save          
        end

        def 基本入力一行分(row, idx, period_id, method_id)
          ActiveRecord::Base.transaction do
            
            name_raw = row[idx["氏名"]]
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

           # if !applicant_number.nil? && !period_id.nil? && !method_id.nil?
           #   duplicates = Admission.where(:applicant_number => applicant_number, :admission_period_id => period_id, :admission_method_id => method_id)
           #   if duplicates.length > 0
           #     logger.info "志願者#" + applicant_number.to_s + "「" + surname + "　" + name + "」が既に" + AdmissionPeriod.find(period_id).name + ":" + AdmissionMethod.find(method_id).name
           #     return
           #   end
           # end

            #入学時期及び入学形態が引数に含まれてればadmissionレコードを作成
            if !period_id.nil? && !method_id.nil?
              admission = Admission.first_or_create(:applicant_number => applicant_number, :admission_period_id => period_id, :admission_method_id => method_id)

              #ここに生徒が登録されてなければ登録し、既に登録されていれば更新を行う
              if admission.student_id.nil?
                student = Student.create!(:surname => surname,
                                :name => name,
                                :surname_reading => surname_reading,
                                :name_reading => name_reading,
                                :enrollment_status_id => Gaku::EnrollmentStatus.find_by_code("applicant").id)
                
                admission.student_id = student.id

                logger.info "志願者「" + surname + "　" + name + "」が未登録でした。"
              else
                student = Student.find(admission.student_id)
                logger.info "志願者「" + surname + "　" + name + "」が既に登録されている為情報を更新対象とします。"
              end

              if admission.save
                admission_method = admission.admission_method
                admission_period = AdmissionPeriod.find(period_id)
                admission_phase = admission_method.admission_phases.first
                admission_phase_state = admission_phase.admission_phase_states.first
                admission_phase_record = AdmissionPhaseRecord.create(
                                                      :admission_phase_id => admission_phase.id,
                                                      :admission_phase_state_id => admission_phase_state.id,
                                                      :admission_id => admission.id)
                
                admission.student.update_column(:enrollment_status_id, Gaku::EnrollmentStatus.find_by_code("applicant").id)
                
                logger.info "志願者「" + surname + "　" + name + 
                  "[" + surname_reading + "　" + name_reading + "]」を" + admission_period.name + "の" + admission_method.name + "に登録しました。"
                志望学科登録(admission, row, idx)
              end
            else
              #既に存在しているかどうかの判断は名前しかない
              # TODO スコープ内名前重複チェック
              student = Student.create!(:surname => surname,
                              :name => name,
                              :surname_reading => surname_reading,
                              :name_reading => name_reading,
                              :enrollment_status_id => Gaku::EnrollmentStatus.find_by_code("applicant").id)

              logger.info "入学時期及び入学形態が設定されていなかった為志願者" + "「" + surname + "　" + name +
                "[" + surname_reading + "　" + name_reading + "]」を入学時期形態なしで志願者リストに登録しました。"
            end
            
            中学校度の内容登録(student, row, idx)
          end
        end


      end
    end
  end
end
