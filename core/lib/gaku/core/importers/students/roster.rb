# -*- encoding: utf-8 -*-
require 'roo'
require 'GenSheet'

module Gaku::Core::Importers::Students
  class Roster
    include Gaku::Core::Importers::Logger

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
      book.each(keymap) do |row|
        process_row(row)
      end
    end

    def get_keymap()
      key_syms = [:id, :name, :name_reading, :middle_name,
        :middle_name_reading, :surname, :surname_reading]
      keymap = {}
      key_syms.each do |key|
        keymap[key.to_s] = I18n.t(key).gsub(' ', '*')
      end
      return keymap
    end

    def get_info(book)
      book.sheet('info')
      book.parse(header_search: book.row(book.first_row)).last
    end

    def student_exists?(row)
      Gaku::Student.exists?(
        student_foreign_id_number: row[:idnum].to_i.to_s)
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
