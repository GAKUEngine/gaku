module Gaku::Importers::Students
  class SchoolStationZaikouseiWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(file_id)
      file = Gaku::ImportFile.find file_id
      if file
        Gaku::Importers::Students::SchoolStationZaikousei.new(file, logger)
      else
        raise 'NO FILE'
      end
    end
  end
end
