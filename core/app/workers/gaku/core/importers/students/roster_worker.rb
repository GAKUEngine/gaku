require 'roo'
require 'GenSheet'

module Gaku
  module Core
    module Importers
      module Students
        class RosterWorker
          include Sidekiq::Worker
           sidekiq_options retry: true, queue: 'roster_worker'

          def perform(file_id)
            file = Gaku::ImportFile.find file_id
            if file
              Gaku::Core::Importers::Students::Roster.new(file)
            else
              raise "NO FILE"
            end
          end

        end
      end
    end
  end
end
