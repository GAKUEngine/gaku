module Gaku
  class ImportFile < ActiveRecord::Base
    has_attached_file :data_file
  end
end
