module Gaku

  class ImporterWorker
    include Sidekiq::Worker

    def perform(params)
      puts "Started ImporterWorker"
      importer = Gaku::Core::Importers::SchoolStation::Zaikousei.new()
      importer.import(params)
    end

  end
end
