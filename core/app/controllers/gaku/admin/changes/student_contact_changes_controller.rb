module Gaku
  module Admin
     module Changes
      class StudentContactChangesController < Admin::BaseController

        load_and_authorize_resource :class =>  Version

        def index
          @changes = Version.student_contacts
          @count = Version.student_contacts.count
        end

      end
    end
  end
end
