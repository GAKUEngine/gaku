require 'GenSheet'

module Gaku::Importers::Students
  class Guardians
    include Gaku::Importers::Logger
    include Gaku::Importers::KeyMapper
    include Gaku::Importers::Students::StudentIdentity
    include Gaku::Importers::Students::PersonalInformation

    GUARDIAN_KEY_SYMS = [:'student.id_number', :'student.foreign_id_number',
                         :student_name, :'guardian.relationship', :full_name, :'guardian.surname',
                         :'surname_reading', :'guardian.name', :name_reading, :birth_date,
                         :sex, :email, :phone,
                         :'address.zipcode', :'address.country', :'address.state',
                         :'address.city', :'address.address2', :'address.address1']

    def initialize(file, logger = nil)
      @logger = logger
      @book = GenSheet.open(File.open(file.data_file.path)) if file
      @info = @book.sheet('info').parse(
        header_search: @book.row(@book.first_row)).last
      set_locale
      process_guardians
    end

    private

    def set_locale
      I18n.locale = @info['locale'].to_sym.presence || I18n.default_locale
    end

    def process_guardians
      @book.sheet(I18n.t('guardian.plural'))

      keymap = get_keymap GUARDIAN_KEY_SYMS
      filtered_keymap = filter_keymap(keymap, @book)

      @book.each_with_index(filtered_keymap) do |row, i|
        process_row(row) unless i == 0
      end
    end

    def process_row(row)
      student = find_student_by_student_ids(row[:student_id_number], row[:student_foreign_id_number])
      add_guardian(row, student) unless student.nil?
    end

    def add_guardian(row, student)
      if row[:'guardian.name'] != nil && row[:'guardian.name'] != '' # name filled
        guardian_name = row[:'guardian.name']
        log 'Guardian with name: ' + guardian_name
        if row[:'guardian.surname'] == nil || row[:'guardian.suranme'] == ''
          guardian_surname = student.surname
        else
          guardian_surname = row[:'guardian.surname']
        end
      elsif !row[:full_name] == nil && row[:full_name] != '' # use full name
        guardian_name_parts = row[:full_name].sub('　', ' ').split(' ')
        guardian_surname = guardian_name_parts.first
        guardian_name = guardian_name_parts.last
      else # no name, so can't register guardian
        return
      end

      #TODO find existing guardian
      log "Registering new Guardian '#{guardian_surname} #{guardian_name}' " +
            "to Student [#{student.student_id_number}] #{student.formatted_name}."
      guardian = student.guardians.new #guardian.new
      guardian.name = guardian_name
      guardian.surname = guardian_surname

      guardian.save

      guardian.name_reading = row[:name_reading]
      guardian.surname_reading = row[:surname_reading]
      guardian.relationship = row[:'guardian.relationship']

      add_address(row, guardian)
      add_contacts(row, guardian)
      reg_sex(row, guardian)
      reg_birthdate(row, guardian)

      guardian.save

      student.guardians << guardian
    end
  end
end

