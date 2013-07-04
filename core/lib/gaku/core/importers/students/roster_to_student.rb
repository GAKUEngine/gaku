require 'GenSheet'

module Gaku::Core::Importers::Students
  class RosterToStudent
    include Gaku::Core::Importers::Logger
    include Gaku::Core::Importers::Students::StudentIdentity

    
    def initialize(row, info, logger = nil)
      @logger = logger
      I18n.locale = info['locale'].to_sym.presence || I18n.default_locale

      student = find_or_create_student(row)
      reg_id(row, student)
      reg_name(row, student)
      reg_sex(row, student)
      reg_birthdate(row, student)
      student.save()

      add_contact(row, student)
      add_address(row, student)
    end

    private

    def find_or_create_student(row)
      student = find_student_by_student_ids(row[:student_id_number], row[:student_foreign_id_number])

      unless student.nil?
        log "Updating student record with Student ID[#{
          student.student_id_number}]."
        return student
      end

      log "Registering new student from importer."
      Gaku::Student.new
    end

    def reg_id(row, student)
      student.student_id_number = row[:student_id_number].to_s
      student.student_foreign_id_number = row[:student_foreign_id_number].to_s
    end

    def reg_name(row, student)
      if (!row[:surname].nil? && row[:surname] != '')
        student.surname = row[:surname]
        student.middle_name = row[:middle_name]
        student.name = row[:name]
        student.surname_reading = row[:surname_reading]
        student.middle_name_reading = row[:middle_name_reading]
        student.name_reading = row[:name_reading]
      elsif (!row[:full_name].nil? && row[:full_name] != '')
        name_parts = row[:full_name].sub("　", " ").split(" ")
        student.surname = name_parts.first
        student.name = name_parts.last

        name_reading_parts = row[:full_name_reading].sub("　", " ").split(" ")
        student.surname_reading = name_reading_parts.first
        student.name_reading = name_reading_parts.last
      else
        log "Could not read student name for: " + row
      end
    end

    def reg_sex(row, student)
      gender = nil
      if row[:sex] == I18n.t('gender.female')
        gender = 0
      elsif row[:sex] == I18n.t('gender.male')
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
      student.birth_date = row[:birth_date]
    end

    def add_contact(row, student)
      phone = row[:phone]
      student.contacts.create!(contact_type_id: Gaku::ContactType.where(name: 'Phone').first.id, is_primary: true,
        is_emergency: true, data: phone) unless (phone.nil? || phone == '')

      email = row[:email]
      student.contacts.create!(contact_type_id: Gaku::ContactType.where(name: 'Email').first.id, is_primary: true,
        is_emergency: true, data: email) unless (email.nil? || email == '')
    end

    def add_address(row, student)
      if row[:'address.address1']
        state = nil
        unless (row[:'address.state'].nil? || row[:'address.state'] == '')
          state = Gaku::State.where(name: row[:'address.state']).first
          if state == nil
            log 'State: "' + row[:'address.state'] + '" not found. Please register and retry import.'
            return
          end
        end

        country = Gaku::Country.where(name: '日本').first
        unless Gaku::Country.where(name: row[:'address.country']).first.nil?
          country = Gaku::Country.where(name: row[:'address.country']).first
        end

        student_address = student.addresses.create!(zipcode: row[:'address.zipcode'],
          country_id: country.id, state: state, city: row[:'city'],
          :address1 => row[:'address.address1'], address2: row[:'address.address2'])
      end
    end
  end
end
