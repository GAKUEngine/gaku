module Gaku
  class Admin::Changes::StudentContactChangesController < Admin::BaseController

    # load_and_authorize_resource class: PaperTrail::Version
    respond_to :html

    def index
      @changes = Gaku::Versioning::ContactVersion.student_contacts
      @count = Gaku::Versioning::ContactVersion.student_contacts.count
    end

  end
end
