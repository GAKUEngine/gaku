module Gaku
  module Core
    module Importers
      module Students
        class RosterWorker
          include Sidekiq::Worker

          def perform(sheet)
            sheet.each(id: 'ID') do |row|
              puts row
              #process_row(row)
            end
          end

          def student_exists?(row)
            if Gaku::Student.exists?(:student_foreign_id_number => row[:idnum].to_i.to_s)
              return true
            end
            false
          end

          def update_student(row)
          end

          def register_student(row)
            ActiveRecord::Base.transaction do
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
    end
  end
end
