require 'roo'
require 'GenSheet'

module Gaku
  module Core
    module Importers
      module Students
        class RosterWorker
          include Sidekiq::Worker

          def perform(file)
            if file.data_file
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
