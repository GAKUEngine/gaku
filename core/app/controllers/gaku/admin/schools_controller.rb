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
        render :show
      end

      def edit_master
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
