module Gaku
  class Admin::Changes::StudentAddressChangesController < Admin::BaseController

    load_and_authorize_resource class: Version

    def index
      @changes = Version.student_addresses
      @count = Version.student_addresses.count
    end

  end
end
