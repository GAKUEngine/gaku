# -*- encoding: utf-8 -*-
module Gaku
  module Importers
    module SchoolStation
      class ZaikouWorker
        include Sidekiq::Worker

        def get_student(row, idx)
          if Gaku::Student.exists?(:student_foreign_id_number => row[idx["foreign_id_number"]].to_i.to_s)
            logger.info "SchoolStationのID番号「#{row[idx["foreign_id_number"]].to_i.to_s}」の生徒が既に登録されている為新規登録及び更新が行われません。"
            return nil
          end

          foreign_id_number = row[idx["foreign_id_number"]].to_i.to_s

          name_parts = row[idx["name"]].to_s().sub("　", " ").split(" ")
          surname = name_parts.first
          name = name_parts.last

          name_reading_parts = row[idx["name_reading"]].to_s().sub("　", " ").split(" ")
          surname_reading = name_reading_parts.first
          name_reading = name_reading_parts.last

          if row[idx["birth_date"]]
            begin
              birth_date = Date.strptime(row[idx["birth_date"]].to_s, "%Y/%m/%d")
            rescue
              birth_date = Date.civil(1899, 12, 31) + row[idx["birth_date"]].to_i.days - 1.day
            end
          end

          if row[idx["gender"]]
            if row[idx["gender"].to_i].to_i == 2
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
                          :student_foreign_id_number => foreign_id_number,
                          :birth_date => birth_date,
                          :gender => gender,
                          :enrollment_status_id => 2)

          return student
        end

        # add student address
        def add_address_to_student(row, idx, student)
          if row[idx["city"]] and row[idx["address1"]]

            if row[idx["state"]]
              state = State.where(:country_numcode => 392, :code => row[idx["state"]].to_i).first
            end

            student_address = student.addresses.create!(:zipcode => row[idx["zipcode"]],
                                      :country_id => idx["country"]["country"]["id"],
                                      :state => state,
                                      :state_id => state.id,
                                      :state_name => state.name,
                                      :city => row[idx["city"]],
                                      :address1 => row[idx["address1"]],
                                      :address2 => row[idx["address2"]])
            if student_address
              logger.info "生徒「#{student.surname} #{student.name}」に住所を登録しました。"
            end
          end
        end

        def add_phone_to_student(row, idx, student)
          if row[idx["phone"]]
            student_contact = student.contacts.create!(:contact_type_id => idx["contact_type"]["contact_type"]["id"],
                                                       :is_primary => true,
                                                       :is_emergency => true,
                                                       :data => row[idx["phone"]])
            if student_contact
              logger.info "生徒「#{student.surname} #{student.name}」に電話番号を登録しました。"
            end
          end
        end

        def add_guardian_to_student(row, idx, student)
          # add primary guardian
          if row[idx["guardian"]["name"]]
            guardian_name_parts = row[idx["guardian"]["name"]].to_s().split("　")
            guardian_surname = guardian_name_parts.first
            guardian_name = guardian_name_parts.last

            if row[idx["guardian"]["name_reading"]]
              guardian_name_reading_parts = row[idx["guardian"]["name_reading"]].to_s().split(" ")
              guardian_surname_reading = guardian_name_reading_parts.first
              guardian_name_reading = guardian_name_reading_parts.last
            end

            guardian = student.guardians.create!(:surname => guardian_surname,
                                                :name => guardian_name,
                                                :surname_reading => guardian_surname_reading,
                                                :name_reading => guardian_name_reading)

            if guardian
              logger.info "生徒「#{student.surname} #{student.name}」に保護者「#{guardian.surname} #{guardian.name}」を登録しました。"
            end

            if row[idx["guardian"]["city"]] and row[idx["guardian"]["address1"]]

              state = State.where(:country_numcode => 392, :code => row[idx["guardian"]["state"]].to_i).first



              guardian_address = guardian.addresses.create!(:zipcode => row[idx["guardian"]["zipcode"]],
                                      :country_id => idx["country"]["country"]["id"],
                                      :state => state,
                                      :state_id => state.id,
                                      :state_name => state.name,
                                      :city => row[idx["guardian"]["city"]],
                                      :address1 => row[idx["guardian"]["address1"]],
                                      :address2 => row[idx["guardian"]["address2"]])
              if guardian_address
                logger.info "生徒「#{student.surname} #{student.name}」の保護者「#{guardian.surname} #{guardian.name}」に住所を登録しました。"
              end

            end

           # if row[idx["guardian"]["phone"]]
           #     contact = Gaku::Contact.new()
           #     contact.contact_type_id = idx["contact_type"]["contact_type"]["id"]
           #     contact.is_primary = true
           #     contact.is_emergency = true
           #     contact.data = row[idx["guardian"]["phone"]]
           #     contact.save

           #     guardian.contacts << contact
           # end
          end
        end

        def perform(sheet, idx)
          #pool = ConnectionPool.new(:size => 10, :timeout => 3) { Redis.new }
          sheet.drop(1).each do |row|
            #pool.with_connection do |redis|
              #redis.lsize(:zaiou)
            process_row(row, idx)
            #end
          end
        end

        def process_row(row, idx)
          ActiveRecord::Base.transaction do
            if row[idx["name"]].nil?
              logger.info "SchoolStation在校生インポータ: 名前が入力されていない行がありました。この行は無視します。\n#{row}"
              return
            end
            
            student = get_student(row, idx)
            if student
              logger.info "SchoolStationインポータにより生徒#{student.surname} #{student.name}が登録されました。\n"
            else
              return
            end

            add_address_to_student(row, idx, student)
            add_phone_to_student(row, idx, student)
            add_guardian_to_student(row, idx, student)
          end
        end
      end
    end
  end
end
