module Gaku
  class Admin::GradingMethodsController < Admin::BaseController

    #load_and_authorize_resource class: GradingMethod

    respond_to :js,   only: %i( new create edit update destroy )
    respond_to :html, only: :index

    before_action :set_grading_method, only: %i( edit update destroy )

    def index
      @grading_methods = GradingMethod.all
      @count = GradingMethod.count
      respond_with @grading_methods
    end

    def new
      @grading_method = GradingMethod.new
      respond_with @grading_method
    end

    def create
      @grading_method = GradingMethod.new(grading_method_params)
      @grading_method.save
      @count = GradingMethod.count
      respond_with @grading_method
    end

    def edit
    end

    def update
      @grading_method.update(grading_method_params)
      respond_with @grading_method
    end

    def destroy
      @grading_method.destroy
      @count = GradingMethod.count
      respond_with @grading_method
    end

    private

    def set_grading_method
      @grading_method = GradingMethod.find(params[:id])
    end

    def grading_method_params
      params.require(:grading_method).permit(attributes).tap do |whitelisted|
        whitelisted['arguments'] = params[:grading_method][:arguments]
      end
    end

    def attributes
      %i( description method name curved arguments )
    end

  end
end
