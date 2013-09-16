module Gaku
  class Admin::GradingMethodSets::GradingMethodSetItemsController < Admin::BaseController

    respond_to :js,   only: %i( new create edit update destroy )

    before_action :set_grading_method_set_item, only: %i( edit update destroy )
    before_action :set_grading_methods,         only: %i( new edit )
    before_action :set_grading_method_set

    def new
      @grading_method_set_item = GradingMethodSetItem.new
      respond_with @grading_method_set_item
    end

    def sort
      params[:'grading-method-set-item'].each_with_index do |id, index|
        @grading_method_set.update_items_positions(id, index)
      end
      render nothing: true
    end

    def create
      @grading_method_set_item = @grading_method_set.items.build(grading_method_set_item_params)
      @grading_method_set_item.save
      set_count
      respond_with @grading_method_set_item
    end

    def edit
    end

    def update
      @grading_method_set_item.update(grading_method_set_item_params)
      respond_with @grading_method_set_item
    end

    def destroy
      @grading_method_set_item.destroy
      set_count
      respond_with @grading_method_set_item
    end

    private

    def set_grading_method_set_item
      @grading_method_set_item = GradingMethodSetItem.find(params[:id])
    end

    def set_grading_method_set
      @grading_method_set = GradingMethodSet.find(params[:grading_method_set_id])
    end

    def set_grading_methods
      @grading_methods = GradingMethod.all.map { |s| [s.name, s.id] }
    end

    def set_count
      @count = @grading_method_set.items.count
    end

    def grading_method_set_item_params
      params.require(:grading_method_set_item).permit(attributes)
    end

    def attributes
      %i(position grading_method_id grading_method_set_id)
    end

  end
end
