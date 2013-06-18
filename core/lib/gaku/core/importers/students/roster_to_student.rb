require 'roo'
require 'GenSheet'

module Gaku::Core::Importers::Students
  class RosterToStudent
    include Gaku::Core::Importers::Logger
    def initialize(row, logger = nil)
      @logger = logger

      student = Gaku::Student.new()
      reg_id(row, student)
      reg_name(row, student)
      reg_sex(row, student)
      reg_birthdate(row, student)
      student.save()

      add_contact(row, student)
      add_address(row, student)
      add_guardian(row, student)
    end

    private
    def reg_id(row, student)
      student.student_id_number = row['student_id_number'].to_s
      student.student_foreign_id_number = row['student_foreign_id_number'].to_s
    end

    def reg_name(row, student)
      student.surname = row['surname']
      student.middle_name = row['middle_name']
      student.name = row['name']
      student.surname_reading = row['surname_reading']
      student.middle_name_reading = row['middle_name_reading']
      student.name_reading = row['name_reading']
    end

    def reg_sex(row, student)
      gender = nil
      if row['sex'] == I18n.t(:female)
        gender = 0
      elsif row['sex'] == I18n.t(:male)
        gender = 1
      end
      student.gender = gender
    end

    def reg_birthdate(row, student)
      #birth_date = Date.strptime(row['birth_date']).to_s
      #begin
      #  birth_date = Date.strptime(row['birth_date'].to_s, "%Y/%m/%d")
      #rescue
      #  birth_date = Date.civil(1899, 12, 31) + row['birth_date'].to_i.days - 1.day
      #end
      student.birth_date = row['birth_date']
    end
    
    def add_contact(row, student)
      phone = row['phone']
      student.contacts.create!(contact_type_id: :phone, is_primary: true,
        is_emergency: true, data: phone) unless (phone.nil? || phone == '')

      email = row['email']
      student.contacts.create!(contact_type_id: :email, is_primary: true,
        is_emergency: true, data: email) unless (phone.nil? || phone == '')
    end

    def add_address(row, student)
      #    if row[idx["city"]] and row[idx["address1"]]

      #      if row[idx["state"]]
      #        state = State.where(:country_numcode => 392, :code => row[idx["state"]].to_i).first
      #      end

      #      student_address = student.addresses.create!(:zipcode => row[idx["zipcode"]],
      #                                :country_id => idx["country"]["country"]["id"],
      #                                :state => state,
      #                                :state_id => state.id,
      #                                :state_name => state.name,
      #                                :city => row[idx["city"]],
      #                                :address1 => row[idx["address1"]],
      #                                :address2 => row[idx["address2"]])
      #      if student_address
      #        logger.info "生徒「#{student.surname} #{student.name}」に住所を登録しました。"
      #      end
      #    end
    end

    def add_guardian(row, student)
        #  # add primary guardian
        #  if row[idx["guardian"]["name"]]
        #    guardian_name_parts = row[idx["guardian"]["name"]].to_s().split("　")
        #    guardian_surname = guardian_name_parts.first
        #    guardian_name = guardian_name_parts.last

        #    if row[idx["guardian"]["name_reading"]]
        #      guardian_name_reading_parts = row[idx["guardian"]["name_reading"]].to_s().split(" ")
        #      guardian_surname_reading = guardian_name_reading_parts.first
        #      guardian_name_reading = guardian_name_reading_parts.last
        #    end

        #    guardian = student.guardians.create!(:surname => guardian_surname,
        #                                        :name => guardian_name,
        #                                        :surname_reading => guardian_surname_reading,
        #                                        :name_reading => guardian_name_reading)

        #    if guardian
        #      logger.info "生徒「#{student.surname} #{student.name}」に保護者「#{guardian.surname} #{guardian.name}」を登録しました。"
        #    end

        #    if row[idx["guardian"]["city"]] and row[idx["guardian"]["address1"]]

        #      state = State.where(:country_numcode => 392, :code => row[idx["guardian"]["state"]].to_i).first



        #      guardian_address = guardian.addresses.create!(:zipcode => row[idx["guardian"]["zipcode"]],
        #                              :country_id => idx["country"]["country"]["id"],
        #                              :state => state,
        #                              :state_id => state.id,
        #                              :state_name => state.name,
        #                              :city => row[idx["guardian"]["city"]],
        #                              :address1 => row[idx["guardian"]["address1"]],
        #                              :address2 => row[idx["guardian"]["address2"]])
        #      if guardian_address
        #        logger.info "生徒「#{student.surname} #{student.name}」の保護者「#{guardian.surname} #{guardian.name}」に住所を登録しました。"
        #      end

        #    end

        #   # if row[idx["guardian"]["phone"]]
        #   # contact = Gaku::Contact.new()
        #   # contact.contact_type_id = idx["contact_type"]["contact_type"]["id"]
        #   # contact.is_primary = true
        #   # contact.is_emergency = true
        #   # contact.data = row[idx["guardian"]["phone"]]
        #   # contact.save

        #   # guardian.contacts << contact
        #   # end
        #  end
    end
  end
end
