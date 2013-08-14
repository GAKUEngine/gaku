module Gaku
  class Admin::Changes::StudentAddressChangesController < Admin::BaseController

    load_and_authorize_resource class: PaperTrail::Version

    def index
      @changes = PaperTrail::Version.student_addresses
      @count = PaperTrail::Version.student_addresses.count
    end

  end
end
