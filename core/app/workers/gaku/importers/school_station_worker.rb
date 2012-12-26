# -*- encoding: utf-8 -*-
module Gaku
  module Core
    module Importers
      class SchoolStationWorker
        include Sidekiq::Worker
        sidekiq_options retry: false

        def perform(importer, records)
          importer = Gaku::Core::Importers::SchoolStation.new()
          case importer
          when "zaikousei"
            importer.import_zaikousei(records)
          end
        end
      end
    end
  end
end
