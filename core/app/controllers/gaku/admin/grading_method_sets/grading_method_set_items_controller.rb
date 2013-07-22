module Gaku
  class Admin::GradingMethodSets::GradingMethodSetItemsController < Admin::BaseController

    load_and_authorize_resource class: GradingMethodSetItem

    respond_to :js, :html

    inherit_resources
    belongs_to :grading_method_set, parent_class: GradingMethodSet

    before_filter :count, only: %i(index create destroy)
    before_filter :load_data, only: %i(new edit)

    def sort
      params[:'grading-method-set-item'].each_with_index do |id, index|
        @grading_method_set.update_items_positions(id, index)
      end
      render nothing: true
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:grading_method_set_item).permit(attributes)]
    end

    private

    def attributes
      %i(position grading_method_id grading_method_set_id)
    end

    def load_data
      @grading_methods = GradingMethod.all.collect { |s| [s.name, s.id] }
    end

    def count
      @count = @grading_method_set.grading_method_set_items.count
    end

  end
end
