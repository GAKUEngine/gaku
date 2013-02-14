module Gaku
  module Admin
    class Schools::CampusesController < Admin::BaseController

      authorize_resource :class => false

      inherit_resources
      belongs_to :school, :parent_class => Gaku::School
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy]

      def update
        @campus = Campus.find(params[:id])
        super do |format|
          if params[:campus][:picture]
            format.html { redirect_to [:admin, @campus.school, @campus], :notice => t('notice.uploaded', :resource => t('picture')) }
          else
            format.js { render }
           end
        end
      end

      private

      def count
        @school = School.find(params[:school_id])
        @count = @school.campuses.count
      end

    end
  end
end
