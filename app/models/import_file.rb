class ImportFile < ActiveRecord::Base
  attr_accessible :context, :data_file

  has_attached_file :data_file
end
