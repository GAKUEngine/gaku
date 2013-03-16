module Gaku
  module Admin
    class SchoolsController < Admin::BaseController

      load_and_authorize_resource :class => Gaku::School

      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]
      before_filter :master_school, :only => [:index, :school_details, :edit_master]

      def school_details
        @school = @master_school
        render 'show', :layout => 'gaku/layouts/show'
      end

      def edit_master
        render 'edit_master', :layout => 'gaku/layouts/show'
      end

      def update
        @school = School.find(params[:id])
        super do |format|
          if params[:school][:picture]
            format.html { redirect_to [:admin, @school], :notice => t('notice.uploaded', :resource => t('picture')) }
          else
            format.js { render }
           end
        end
      end

      private

      def master_school
        @master_school = School.where(:is_primary => true).first
      end

      def count
        @count = School.count
      end

    end
  end
end
