require 'roo'
require 'GenSheet'

module Gaku::Core::Importers::Students
  class Roster
    include Gaku::Core::Importers::Logger
    include Gaku::Core::Importers::Students::RosterKeys

    def initialize(file, logger)
      @logger = logger
      file_handle = File.open file.data_file.path
      book = Roo::Spreadsheet.open file_handle
      info = get_info(book)
      open_roster(info, book)
      start(info, book)
    end

    private

    def open_roster(info, book)
      I18n.locale = info['locale'].to_sym.presence || I18n.default_locale
      book.sheet(I18n.t('student.roster'))
    end

    def start(info, book)
      keymap = get_keymap
      filtered_keymap = filter_keymap(keymap, book)

      book.each_with_index(filtered_keymap) do |row, i|
        process_row(row, info) unless i == 0
      end
    end

    def get_info(book)
      book.sheet('info')
      book.parse(header_search: book.row(book.first_row)).last
    end

    def student_exists?(row)
      (
        Gaku::Student.exists?(
          student_foreign_id_number: row[:foreign_id].to_i.to_s) ||
        Gaku::Student.exists?(
          student_foreign_id_number: row[:id].to_i.to_s)
      )
    end

    def update_student(row)
    end

    def register_student(row, info)
      ActiveRecord::Base.transaction do
        Gaku::Core::Importers::Students::RosterToStudent.new(row, info, @logger)
      end
    end

    def process_row(row, info)
      if student_exists?(row)
        update_student(row)
      else
        register_student(row, info)
      end
    end
  end
end
