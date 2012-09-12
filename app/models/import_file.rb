# == Schema Information
#
# Table name: import_files
#
#  id                     :integer          not null, primary key
#  context                :string(255)
#  importer_type          :string(255)
#  data_file_file_name    :string(255)
#  data_file_content_type :string(255)
#  data_file_file_size    :integer
#  data_file_updated_at   :datetime
#

class ImportFile < ActiveRecord::Base

  attr_accessible :context, :data_file, :importer_type

  has_attached_file :data_file
end
