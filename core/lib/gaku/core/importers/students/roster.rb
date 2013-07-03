require 'GenSheet'

module Gaku::Core::Importers::Students
  class Roster

    include Gaku::Core::Importers::Logger
    include Gaku::Core::Importers::KeyMapper
  
    ROSTER_KEY_SYMS = [:student_id_number, :student_foreign_id_number,
      :full_name, :full_name_reading, :name, :name_reading,
      :middle_name, :middle_name_reading, :surname, :surname_reading,
      :sex, :birth_date, :admitted, :phone, :email,
      :'address.zipcode', :'address.country', :'address.state',
      :'address.city', :'address.address2', :'address.address1']

    GUARDIAN_KEY_SYMS = [:student_id_number, :student_foreign_id_number,
      :'guardian.relationship', :full_name, :'guardian.surname',
      :'surname_reading', :'guardian.name', :name_reading, :birth_date,
      :sex, :emai, :phone,
      :'address.zipcode', :'address.country', :'address.state',
      :'address.city', :'address.address2', :'address.address1']

    def initialize(file, logger = nil)
      @logger = logger
      @book = GenSheet.open(File.open(file.data_file.path)) if file
      @info = @book.sheet('info').parse(
        header_search: @book.row(@book.first_row)).last
      set_locale
      process_book
    end

    private

    def set_locale
      I18n.locale = @info['locale'].to_sym.presence || I18n.default_locale
    end

    def process_book
      log "process roster"
      process_roster
      #process_guardians
    end

    def process_roster
      @book.sheet(I18n.t('student.roster'))

      keymap = get_keymap ROSTER_KEY_SYMS
      filtered_keymap = filter_keymap(keymap, @book)

      @book.each_with_index(filtered_keymap) do |row, i|
        process_row(row) unless i == 0
      end
    end

    def process_guardians
      @book.sheet(I18n.t('guardian.plural'))

      keymap = get_keymap GUARDIAN_KEY_SYMS
      filtered_keymap = filter_keymap(keymap, @book)

      @book.each_with_index(filtered_keymap) do |row, i|
        process_row(row) unless i == 0
      end
    end

    def student_exists?(row)
      (
        Gaku::Student.exists?(
          student_foreign_id_number: row[:foreign_id].to_i.to_s) ||
        Gaku::Student.exists?(
          student_id_number: row[:id].to_i.to_s)
      )
    end

    def update_student(row)
    end

    def register_student(row)
      ActiveRecord::Base.transaction do
        Gaku::Core::Importers::Students::RosterToStudent.new(
          row, @info, @logger)
      end
    end

    def process_row(row)
      if student_exists?(row)
        update_student(row)
      else
        register_student(row)
      end
    end
  end
end
