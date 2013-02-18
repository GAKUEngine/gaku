module Gaku
  module Admin
     module Changes
      class StudentChangesController < Admin::BaseController

        load_and_authorize_resource :class =>  StudentVersion

        def index
          @changes = StudentVersion.all
          @count = StudentVersion.count
        end

      end
    end
  end
end
