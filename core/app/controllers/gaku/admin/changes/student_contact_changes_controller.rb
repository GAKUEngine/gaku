module Gaku
  class Admin::Changes::StudentContactChangesController < Admin::BaseController

    load_and_authorize_resource class: PaperTrail::Version

    def index
      @changes = PaperTrail::Version.student_contacts
      @count = PaperTrail::Version.student_contacts.count
    end

  end
end
