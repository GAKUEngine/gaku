module Gaku
  class Admin::GradingMethodSetsController < Admin::BaseController

    #load_and_authorize_resource class: GradingMethodSet

    respond_to :js,   only: %i( new create edit update destroy make_primary )
    respond_to :html, only: %i( index show )

    before_action :set_grading_method_set, only: %i( edit update show destroy make_primary )

    def index
      @grading_method_sets = GradingMethodSet.all
      @count = GradingMethodSet.count
      respond_with @grading_method_sets
    end

    def new
      @grading_method_set = GradingMethodSet.new
      respond_with @grading_method_set
    end

    def create
      @grading_method_set = GradingMethodSet.new(grading_method_set_params)
      @grading_method_set.save
      @count = GradingMethodSet.count
      respond_with @grading_method_set
    end

    def edit
    end

    def show
    end

    def update
      @grading_method_set.update(grading_method_set_params)
      respond_with @grading_method_set
    end

    def destroy
      if @grading_method_set.primary?
        GradingMethodSet.first.try(:make_primary)
      end
      @grading_method_set.destroy
      @count = GradingMethodSet.count
      respond_with @grading_method_set
    end

    def make_primary
      @grading_method_set.make_primary
      respond_with @grading_method_set
    end

    private

    def set_grading_method_set
      @grading_method_set = GradingMethodSet.find(params[:id])
    end

    def grading_method_set_params
      params.require(:grading_method_set).permit(attributes)
    end

    def attributes
      %i(display_deviation display_rank name primary rank_order)
    end

  end
end
