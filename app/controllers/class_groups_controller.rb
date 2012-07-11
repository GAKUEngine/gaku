class ClassGroupsController < ApplicationController
	
  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_before_show, :only => :show

  def destroy
    destroy! :flash => !request.xhr?
  end
  
  private
  
    def load_before_show
      @new_semester = Semester.new
      @new_course = Course.new
    end

end
