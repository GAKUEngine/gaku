module Gaku
  module Admin
    class AdmissionMethodsController < GakuController

      inherit_resources 
      actions :index, :show, :new, :create, :update, :edit, :destroy
      
      respond_to :js, :html

      before_filter :admission_methods_count, :only => [:create, :destroy]

      private
        def admission_methods_count 
          @admission_methods_count = AdmissionMethod.count
        end
    end
  end
end
