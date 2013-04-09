module Gaku
  module Admin
    class SchoolYears::SemestersController < Admin::BaseController

      authorize_resource :class => false

      inherit_resources
      belongs_to :school_year, :parent_class => Gaku::SchoolYear


      respond_to :js, :html
      before_filter :count, :only => [:create, :destroy, :index]

      private

      def count
        @count = Semester.count
      end

    end
  end
end