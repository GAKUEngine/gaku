# -*- encoding: utf-8 -*-
module Gaku

  class StudentWorker
    include Sidekiq::Worker

    def perform(id)
      logger.info "Started StudentWorker"

      importer = Gaku::Core::Importers::SchoolStation::Zaikousei.new()
      importer.set_logger(logger)
      file = ImportFile.find(id)

      if file
        book = Spreadsheet.open(file.data_file.path)
        sheet = book.worksheet('CAMPUS_ZAIKOTBL')

        importer.process_records(sheet)
        logger.info(importer.loginfo)

      end

      results = Hash.new
      results[:status] = "OK"
      results[:record_count] = importer.record_count

      logger.info "--------------------------------------------------"
      logger.info "Created #{importer.record_count} student records in the db"
      logger.info "Students in the db: #{Student.count}"
      logger.info "Contacts in the db: #{Contact.count}"
      logger.info "Addresses in the db: #{Address.count}"
      logger.info "Guardians in the db: #{Guardian.count}"

      return results
    end


  end
end
