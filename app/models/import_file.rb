class ImportFile < ActiveRecord::Base

  attr_accessible :context, :data_file, :importer_type

  has_attached_file :data_file
end
