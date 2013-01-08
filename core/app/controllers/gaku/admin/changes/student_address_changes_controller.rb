module Gaku
  module Admin
     module Changes
      class StudentAddressChangesController < Admin::BaseController

        def index
          @changes = Version.student_addresses
          @count = Version.student_addresses.count
        end

      end
    end
  end
end
