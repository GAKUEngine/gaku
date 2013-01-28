module Gaku
  module Admin
     module Changes
      class StudentContactChangesController < Admin::BaseController

        def index
          @changes = Version.student_contacts
          @count = Version.student_contacts.count
        end

      end
    end
  end
end
