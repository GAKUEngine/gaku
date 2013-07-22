module Gaku
  class Admin::GradingMethodsController < Admin::BaseController

    load_and_authorize_resource class: GradingMethod

    respond_to :js, :html

    inherit_resources

    before_filter :count, only: %i(index create destroy)

    protected

    def resource_params
      return [] if request.get?
      [params.require(:grading_method).permit(attributes)]
    end

    private

    def count
      @count = GradingMethod.count
    end

    def attributes
      %i(description method name curved arguments)
    end

  end
end
