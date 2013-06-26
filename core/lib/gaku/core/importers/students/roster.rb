require 'roo'
require 'GenSheet'

module Gaku::Core::Importers::Students
  class Roster

    include Gaku::Core::Importers::Logger
    include Gaku::Core::Importers::Students::RosterKeys

    attr_accessor :book, :info, :logger

    def initialize(file, logger)
      @logger = logger
      @book = Roo::Spreadsheet.open(File.open(file.data_file.path)) if file
      @info = @book.sheet('info').parse(header_search: @book.row(@book.first_row)).last
    end

    def start
      set_locale
      process_book
    end

    private

    def set_locale
      I18n.locale = @info['locale'].to_sym.presence || I18n.default_locale
    end

    def process_book
      @book.sheet(I18n.t('student.roster'))

      keymap = get_keymap
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
        Gaku::Core::Importers::Students::RosterToStudent.new(row, @logger).start
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
