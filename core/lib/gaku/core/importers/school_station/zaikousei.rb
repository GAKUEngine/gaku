# -*- encoding: utf-8 -*-
require 'roo'
require 'GenSheet'

module Gaku::Core::Importers::SchoolStation
  class Zaikousei
    include Gaku::Core::Importers::Logger

    def initialize(file, logger)
      @logger = logger
      file_handle = File.open file.data_file.path
      book = Roo::Spreadsheet.open file_handle
      book = fix_for_school_station(book)
      # info = get_info(book)
      # open_roster(info, book)
      # start(info, book)
    end

    private

    def fix_for_school_station(book)
      p 'henkantyu- dayo-'
    end

    def open_roster(info, book)
      I18n.locale = info['locale'].to_sym.presence || I18n.default_locale
      book.sheet(I18n.t('student.roster'))
    end

    def start(info, book)
      keymap = get_keymap
      book.each_with_index(keymap) do |row, i|
        process_row(row) unless i == 0
      end
    end

    def get_keymap()
      key_syms = [:student_id_number, :student_foreign_id_number, :name, :name_reading, :middle_name,
        :middle_name_reading, :surname, :surname_reading, :sex, :birth_date, :admitted, :phone]
      keymap = {}
      key_syms.each do |key|
        keymap[key.to_s] = '^' + I18n.t(key) + '$'#.gsub(' ', ' ')
        #TODO check if keys exist in header. If they do not then remove them from hash.
        log 'KEY[' + key.to_s + ']: ' + keymap[key.to_s]
      end
      return keymap
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

    def register_student(row)
      ActiveRecord::Base.transaction do
        Gaku::Core::Importers::Students::RosterToStudent.new(row)
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
