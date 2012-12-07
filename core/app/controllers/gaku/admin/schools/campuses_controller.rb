module Gaku
  module Admin
    class Schools::CampusesController < Admin::BaseController

      inherit_resources
      belongs_to :school, :parent_class => Gaku::School
      #actions :index, :show, :new, :update, :edit, :destroy

      respond_to :js, :html

      before_filter :school
      before_filter :count, :only => [:create,:destroy]
      before_filter :before_show, :only => [:show]


      #def create
      #  super do |format|
      #    if @campus.save && @school.campuses << @campus
      #      format.js { render 'create' }
      #    end
      #  end
      #end

      private
        def before_show
          @address = Address.new
        end

        def school
          @school = School.find(params[:school_id])
        end

        def count
          school
          @count = @school.campuses.count
        end

    end
  end
end
