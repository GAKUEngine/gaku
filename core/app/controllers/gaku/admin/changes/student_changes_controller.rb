module Gaku
  module Admin
     module Changes
      class StudentChangesController < Admin::BaseController

        def index
          @changes = StudentVersion.all
          @count = StudentVersion.count
        end

      end
    end
  end
end
