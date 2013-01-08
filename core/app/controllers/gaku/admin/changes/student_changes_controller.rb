module Gaku
  module Admin
     module Changes
      class StudentChangesController < Admin::BaseController

        def index
          @changes = Version.students
          @count = Version.students.count
        end

      end
    end
  end
end
