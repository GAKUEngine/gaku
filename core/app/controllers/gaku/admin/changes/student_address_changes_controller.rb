module Gaku
  module Admin
     module Changes
      class StudentAddressChangesController < Admin::BaseController

        load_and_authorize_resource :class =>  Version

        def index
          @changes = Version.student_addresses
          @count = Version.student_addresses.count
        end

      end
    end
  end
end
