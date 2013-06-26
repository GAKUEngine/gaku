# encoding: UTF-8

require 'roo'
require 'GenSheet'

module Gaku::Core::Importers::Students
  class RosterToStudent
    include Gaku::Core::Importers::Logger

    def initialize(row, logger = nil)
      @logger = logger
      @row = row
    end

    def start
      @student = Gaku::Student.create! student_id_number: student_id_number,
                                 student_foreign_id_number: student_foreign_id_number,
                                 name: name, middle_name: middle_name, surname: surname,
                                 name_reading: name_reading,
                                 surname_reading: surname_reading,
                                 middle_name_reading: middle_name_reading,
                                 gender: gender, birth_date: birth_date

      add_contact
      add_address
      add_guardian
    end

    private

    def student_id_number
      @row[:student_id_number].to_s
    end

    def student_foreign_id_number
      @row[:student_foreign_id_number].to_s
    end

    def surname
      @row[:surname]
    end

    def middle_name
      @row[:middle_name]
    end

    def name
      @row[:name]
    end

    def surname_reading
      @row[:surname_reading]
    end

    def middle_name_reading
      @row[:middle_name_reading]
    end

    def name_reading
      @row[:name_reading]
    end

    def gender
      if @row[:sex] == I18n.t('gender.female')
        0
      elsif @row[:sex] == I18n.t('gender.male')
        1
      end
    end

    def birth_date
      #birth_date = Date.strptime(row['birth_date']).to_s
      #begin
      #  birth_date = Date.strptime(row['birth_date'].to_s, "%Y/%m/%d")
      #rescue
      #  birth_date = Date.civil(1899, 12, 31) + row['birth_date'].to_i.days - 1.day
      #end
      @row[:birth_date]
    end

    def add_contact
      phone = @row[:phone]
      @student.contacts.create!(contact_type_id: Gaku::ContactType.where(name: 'Phone').first.id, is_primary: true,
        is_emergency: true, data: phone) unless (phone.nil? || phone == '')

      email = @row[:email]
      @student.contacts.create!(contact_type_id: Gaku::ContactType.where(name: 'Email').first.id, is_primary: true,
        is_emergency: true, data: email) unless (email.nil? || email == '')
    end

    def add_address
      if @row[:'address.address1']
        state = nil
        unless (@row[:'address.state'].nil? || @row[:'address.state'] == '')
          state = Gaku::State.where(name: @row[:'address.state']).first
          if state == nil
            log 'State: "' + @row[:'address.state'] + '" not found. Please register and retry import.'
            return
          end
        end

        country = Gaku::Country.where(name: '日本').first
        unless Gaku::Country.where(name: @row[:'address.country']).first.nil?
          country = Gaku::Country.where(name: @row[:'address.country']).first
        end

        @student.addresses.create!(zipcode: @row[:'address.zipcode'],
          country: country, state: state, city: @row[:'city'],
          :address1 => @row[:'address.address1'], address2: @row[:'address.address2'])
      end
    end

    def add_guardian
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
