module Gaku
  module Admin
    class EnrollmentStatusTypesController < Admin::BaseController

      inherit_resources
      actions :index, :show, :new, :create, :update, :edit, :destroy
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]

      private
        def count
          @count = EnrollmentStatusType.count
        end
    end
  end
end
