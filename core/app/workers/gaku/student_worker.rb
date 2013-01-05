# -*- encoding: utf-8 -*-
module Gaku

  class StudentWorker
    include Sidekiq::Worker

    def perform(id)
      logger.info "Started StudentWorker"

      importer = Gaku::Core::Importers::SchoolStation::Zaikousei.new()
      file = ImportFile.find(id)

      if file
        book = Spreadsheet.open(file.data_file.path)
        sheet = book.worksheet(0)

        ActiveRecord::Base.transaction do
          @record_count = 0

          idx = importer.get_default_index
          
          country = Country.find_by_numcode(392)
          contact_type = ContactType.find_by_name("Phone")


          sheet.each do |row|
            unless book.worksheet('CAMPUS_ZAIKOTBL').first == row

              if row[idx[:name]].nil?
                next
              end

              if Gaku::Student.exists?(:student_foreign_id_number => row[idx[:foreign_id_number]])
                logger.info "Student with foreign_id: #{row[idx[:foreign_id_number]]} already exists"
                next
              end

              @record_count += 1

              name_parts = row[idx[:name]].to_s().sub("　", " ").split(" ")
              surname = name_parts.first
              name = name_parts.last

              name_reading_parts = row[idx[:name_reading]].to_s().sub("　", " ").split(" ")
              surname_reading = name_reading_parts.first
              name_reading = name_reading_parts.last

              if row[idx[:birth_date]]
                birth_date = Date.parse(row[idx[:birth_date]].to_s)
                if birth_date.nil?
                  birth_date = Date.strptime(row[idx[:birth_date]].to_s, "%Y/%m/%d")
                end
              end

              if row[idx[:gender]]
                if row[idx[:gender]].to_i == 2
                  gender = 0
                else
                  gender = 1
                end
              end

              # check for existing
              student = Student.create!(:surname => surname,
                              :name => name,
                              :surname_reading => surname_reading,
                              :name_reading => name_reading,
                              :student_foreign_id_number => row[idx[:foreign_id_number]],
                              :birth_date => birth_date,
                              :gender => gender)

              if student
                logger.info "--------------------------------------------------"
                logger.info "Created student: #{student.id}, name: #{student.name}"
              else
                next
              end

              # add student address
              if row[idx[:city]] and row[idx[:address1]]

                if row[idx[:state]]
                  state = State.where(:country_numcode => 392, :code => row[idx[:state]].to_i).first
                end

                student_address = student.addresses.create!(:zipcode => row[idx[:zipcode]],
                                          :country_id => country.id,
                                          :state => state,
                                          :state_id => state.id,
                                          :state_name => state.name,
                                          :city => row[idx[:city]],
                                          :address1 => row[idx[:address1]],
                                          :address2 => row[idx[:address2]])
                if student_address
                  logger.info "Created address: #{student_address.id} for student: #{student.id}"
                end
              end

              if row[idx[:phone]]
                student_contact = student.contacts.create!(:contact_type_id => contact_type.id,
                                                           :is_primary => true,
                                                           :is_emergency => true,
                                                           :data => row[idx[:phone]])
                if student_contact
                  logger.info "Created contact: #{student_contact.id} for student: #{student.id}"
                end

              end

              # add primary guardian
              if row[idx[:guardian][:name]]
                guardian_name_parts = row[idx[:guardian][:name]].to_s().split("　")
                guardian_surname = guardian_name_parts.first
                guardian_name = guardian_name_parts.last


                if row[idx[:guardian][:name_reading]]
                  guardian_name_reading_parts = row[idx[:guardian][:name_reading]].to_s().split(" ")
                  guardian_surname_reading = guardian_name_reading_parts.first
                  guardian_name_reading = guardian_name_reading_parts.last
                end

                guardian = student.guardians.create!(:surname => guardian_surname,
                                                    :name => guardian_name,
                                                    :surname_reading => guardian_surname_reading,
                                                    :name_reading => guardian_name_reading)

                if guardian
                  logger.info "Created guardian: #{guardian.id} for student: #{student.id}"
                end

                if row[idx[:guardian][:city]] and row[idx[:guardian][:address1]]

                  state = State.where(:country_numcode => 392, :code => row[idx[:guardian][:state]].to_i).first



                  guardian_address = guardian.addresses.create!(:zipcode => row[idx[:guardian][:zipcode]],
                                          :country_id => country.id,
                                          :state => state,
                                          :state_id => state.id,
                                          :state_name => state.name,
                                          :city => row[idx[:guardian][:city]],
                                          :address1 => row[idx[:guardian][:address1]],
                                          :address2 => row[idx[:guardian][:address2]])
                  if guardian_address
                    logger.info "Created address: #{guardian_address.id} for guardian: #{guardian.id}"
                  end

                end

                if row[idx[:guardian][:phone]]
                    contact = Gaku::Contact.new()
                    contact.contact_type = contact_type
                    contact.is_primary = true
                    contact.is_emergency = true
                    contact.data = row[idx[:guardian][:phone]]
                    contact.save

                    guardian.contacts << contact
                end
              end

            else #1st row, try parsing index
              idx = importer.check_index(row, idx)
            end
          end
        end
      end

      results = Hash.new
      results[:status] = "OK"
      results[:record_count] = @record_count

      logger.info "--------------------------------------------------"
      logger.info "Created #{@record_count} student records in the db"
      logger.info "Students in the db: #{Student.count}"
      logger.info "Contacts in the db: #{Contact.count}"
      logger.info "Addresses in the db: #{Address.count}"
      logger.info "Guardians in the db: #{Guardian.count}"

      return results
    end


  end
end
