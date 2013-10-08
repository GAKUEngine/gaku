require 'GenSheet'

module Gaku::Importers::Students
  class Roster
    include Gaku::Importers::Logger
    include Gaku::Importers::KeyMapper

    ROSTER_KEY_SYMS = [:'student.id_number', :'student.foreign_id_number',
                       :full_name, :full_name_reading, :name, :name_reading,
                       :middle_name, :middle_name_reading, :surname, :surname_reading,
                       :sex, :birth_date, :admitted, :phone, :email,
                       :'address.zipcode', :'address.country', :'address.state',
                       :'address.city', :'address.address2', :'address.address1']

    def initialize(file, logger = nil)
      @logger = logger
      @book = GenSheet.open(File.open(file.data_file.path)) if file
      @info = @book.sheet('info').parse(
        header_search: @book.row(@book.first_row)).last
      set_locale
      process_roster

      Gaku::Importers::Students::Guardians.new(file, logger)
    end

    private

    def set_locale
      I18n.locale = @info['locale'].to_sym.presence || I18n.default_locale
    end

    def process_roster
      @book.sheet(I18n.t('student.roster'))

      keymap = get_keymap ROSTER_KEY_SYMS
      filtered_keymap = filter_keymap(keymap, @book)

      @book.each_with_index(filtered_keymap) do |row, i|
        process_row(row) unless i == 0
      end
    end

    def process_row(row)
      ActiveRecord::Base.transaction do
        Gaku::Importers::Students::RosterToStudent.new(
          row, @info, @logger)
      end
    end
  end
end
