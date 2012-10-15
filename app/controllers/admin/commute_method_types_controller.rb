module Admin
  class CommuteMethodTypesController < Admin::BaseController

  	inherit_resources
  	actions :index, :show, :new, :create, :update, :edit, :destroy

  	respond_to :js, :html

  	before_filter :commute_method_types_count, :only => [:create,:destroy]

  	private
  	  def commute_method_types_count
  	  	@commute_method_types_count = CommuteMethodType.count
  	  end
    
  end
end
   	