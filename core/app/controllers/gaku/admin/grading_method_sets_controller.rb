module Gaku
  class Admin::GradingMethodSetsController < Admin::BaseController

    load_and_authorize_resource class: GradingMethodSet

    respond_to :js, :html

    inherit_resources

    before_filter :count, only: %i(index create destroy)

    def destroy
      super do |format|
        if @grading_method_set.is_primary?
          GradingMethodSet.first.try(:make_primary)
        end
        format.js { render }
      end
    end

    def make_primary
      @grading_method_set.make_primary
      respond_with @grading_method_set
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:grading_method_set).permit(attributes)]
    end

    private

    def count
      @count = GradingMethodSet.count
    end

    def attributes
      %i(display_deviation display_rank name is_primary rank_order)
    end

  end
end
