# -*- encoding: utf-8 -*-
class ImporterWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(importer_class, importer_method, records)
    case importer_class
    when "SchoolStation"
      importer = Gaku::Core::Importers::SchoolStation.new()
      case importer_method
      when "在校生"
        importer.import_zaikousei(records)
      end
    end
  end
end
