require 'roo'
require 'GenSheet'

module Gaku::Core::Importers::SchoolStation
  class ZaikouseiWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(file_id)
      file = Gaku::ImportFile.find file_id
      if file
        Gaku::Core::Importers::SchoolStation::Zaikousei.new(file, logger)
      else
        raise 'NO FILE'
      end
    end
  end
end