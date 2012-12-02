module Gaku
  module Admin
    class CommuteMethodTypesController < Admin::BaseController

    	inherit_resources
    	actions :index, :show, :new, :create, :update, :edit, :destroy

    	respond_to :js, :html

      before_filter :load_before_index, :only => [:index]
    	before_filter :count, :only => [:create,:destroy, :index]

    	private
    	  def count
    	  	@count = CommuteMethodType.count
    	  end

        def load_before_index
          @commute_method_type = CommuteMethodType.new
        end

    end
  end
end

