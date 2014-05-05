module Gaku
  class Admin::Changes::StudentAddressChangesController < Admin::BaseController

    # load_and_authorize_resource class: PaperTrail::Version

    respond_to :html

    def index
      @changes = Gaku::Versioning::AddressVersion.student_addresses
      @count = Gaku::Versioning::AddressVersion.student_addresses.count
    end

  end
end
