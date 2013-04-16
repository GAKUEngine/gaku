module Gaku
  module Admin
     module Changes
      class StudentChangesController < Admin::BaseController

        load_and_authorize_resource :class =>  StudentVersion
        respond_to :html, :js

        inherit_resources
        actions :index

        def index
          @count = StudentVersion.count
          index!
        end

        protected

        def collection
          @changes = StudentVersion.page(params[:page]).per(Preset.changes_per_page)
        end

      end
    end
  end
end
