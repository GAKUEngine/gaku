require 'GenSheet'

module Gaku::Core::Importers::Students
  class Guardians
    include Gaku::Core::Importers::Logger
    include Gaku::Core::Importers::KeyMapper

    GUARDIAN_KEY_SYMS = [:student_id_number, :student_foreign_id_number,
      :'guardian.relationship', :full_name, :'guardian.surname',
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
      #if row[:student_id_number].nil? || row[:student_id_number] == ''
      #  if row[:student_id_number].nil? || row[:student_id_number] == ''
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

