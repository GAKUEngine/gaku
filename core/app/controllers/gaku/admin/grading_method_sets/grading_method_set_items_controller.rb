module Gaku
  module Admin
    module GradingMethodSets
      class GradingMethodSetItemsController < Admin::BaseController

        load_and_authorize_resource :class =>  Gaku::GradingMethodSetItem


        inherit_resources
        respond_to :js, :html
        belongs_to :grading_method_set, parent_class: Gaku::GradingMethodSet

        before_filter :count, :only => [:index, :create, :destroy]
        before_filter :load_data, :only => [:new, :edit]

        def sort
          params[:'grading-method-set-item'].each_with_index do |id, index|
            @grading_method_set.update_items_positions(id, index)
          end
          render :nothing => true
      end

        private

        def load_data
          @grading_methods = GradingMethod.all.collect { |s| [s.name, s.id] }
        end

        def count
          @count = @grading_method_set.grading_method_set_items.count
        end
      end
    end
  end
end