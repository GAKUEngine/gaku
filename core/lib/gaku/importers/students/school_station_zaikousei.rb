require 'roo'
require 'GenSheet'

module Gaku::Importers::Students
  class SchoolStationZaikousei
    include Gaku::Importers::Logger
    include Gaku::Importers::Students::RosterKeys

    def initialize(file, logger)
      @logger = logger
      file_handle = File.open file.data_file.path
      book = Roo::Spreadsheet.open file_handle
      open_zaikousei(book)
      fix_index(book)
      keymap = get_keymap
     # fix_names(book, keymap)
    #  fix_genders(book, keymap)
    #  start(book, keymap)
    end

    private
    def open_zaikousei(book)
      I18n.locale = :ja
      book.sheet(0)
    end

    def fix_index(book)
      last_column = 0
      book.row(1).each_with_index do |cell, i|
        case cell
        when 'STUDENTCD'
          book.set 1, i, I18n.t(:student_id_number)
        when 'ZAINAM_C'
          book.set 1, i, I18n.t(:name)
        when 'ZAINAM_K'
          book.set 1, i, I18n.t(:name_reading)
        when 'ZAISEXKN'
          book.set 1, i, I18n.t(:sex)
        end

        last_column = i
      end

      book.set 1, (last_column += 1), I18n.t(:surname)
      book.set 1, (last_column += 1), I18n.t(:surname_reading)

      book.row(1).each do |cell|
        log 'cell: ' + cell.to_s
      end
      #book.row(1..book.last_row).each do |row|
      #  log row
      #end
    end

    def _fix_name(row)
      name_parts = row[:name].sub('　', ' ').split(' ')
      surname = name_parts.first
      name = name_parts.last
      row[:surname] = surname
      row[:name] = name

      name_reading_parts = row[:name_reading].sub('　', ' ').split(' ')
      surname_reading = name_reading_parts.first
      name_reading = name_reading_parts.last
      row[:surname_reading] = surname_reading
      row[:name_reading] = name_reading
    end

    def fix_names(book, keymap)
      book.each_with_index(keymap) do |row, i|
        _fix_name(row) unless i == 0
      end
      book.each(keymap) do |row|
        log '名前変換 姓[' + row[:surname] + ']　名[' + row[:name] + ']'
      end
    end

    def fix_genders(book, keymap)
    end

    def start(book, keymap)
      book.each_with_index(keymap) do |row, i|
        process_row(row) unless i == 0
      end
    end

    def student_exists?(row)
      Gaku::Student.exists?(
        student_foreign_id_number: row[:foreign_id].to_i.to_s)
    end

    def update_student(row)
    end

    def register_student(row)
      ActiveRecord::Base.transaction do
        Gaku::Importers::Students::RosterToStudent.new(row)
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
