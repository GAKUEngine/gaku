module Gaku
  module Admin
    class AdmissionMethodsController < GakuController

      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]

      private
        def count
          @count = AdmissionMethod.count
        end
    end
  end
end
