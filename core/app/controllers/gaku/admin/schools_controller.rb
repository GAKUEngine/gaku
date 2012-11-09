module Gaku
  module Admin
    class SchoolsController < Admin::BaseController
     	
      inherit_resources
      actions :index, :show, :new, :create, :update, :edit, :destroy

      respond_to :js, :html

      before_filter :schools_count, :only => [:create, :destroy]
      before_filter :master_school, :only => [:index, :school_details, :edit_master]

      def school_details
        @school = @master_school
        render 'show'
      end

      def edit_master
      end

      def update
        super do |format|
          format.html { redirect_to admin_school_details_path, :notice => 'blq' }
        end
      end

      private

        def master_school
          @master_school = School.where(:is_primary => true).first
        end

        def schools_count
          @schools_count = School.count
        end

    end
  end
end