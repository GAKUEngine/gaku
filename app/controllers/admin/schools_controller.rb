module Admin
  class SchoolsController < Admin::BaseController
   	
    inherit_resources
    actions :index, :show, :new, :create, :update, :edit, :destroy

    respond_to :js, :html

    before_filter :schools_count, :only => [:create, :destroy]

    private

      def schools_count
        @schools_count = School.count
      end

  end
end