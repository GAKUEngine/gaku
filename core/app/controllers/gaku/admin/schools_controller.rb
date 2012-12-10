module Gaku
  module Admin
    class SchoolsController < Admin::BaseController

      inherit_resources
      actions :index, :show, :new, :create, :update, :edit, :destroy

      respond_to :js, :html

      before_filter :count, :only => [:create, :destroy, :index]
      before_filter :master_school, :only => [:index, :school_details, :edit_master]

      def school_details
        @school = @master_school
        render 'show'
      end

      def edit_master
      end

      def update
        super do |format|
          format.js { render 'update' }
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
