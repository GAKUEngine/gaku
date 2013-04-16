module Gaku
  module Admin
    class CommuteMethodTypesController < Admin::BaseController

      load_and_authorize_resource :class =>  Gaku::CommuteMethodType

    	inherit_resources
    	respond_to :js, :html

    	before_filter :count, :only => [:create, :destroy, :index]


      protected

      def collection
        @commute_method_types = CommuteMethodType.includes(:translations)
      end

    	private

  	  def count
  	  	@count = CommuteMethodType.count
  	  end

    end
  end
end

