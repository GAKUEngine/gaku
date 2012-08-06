class ClassGroupsController < ApplicationController
	
  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_before_show, :only => :show
  before_filter :load_before_index, :only => :index

  def create
    super do |format|
      format.js { render }
    end
    
  end

  def destroy
    destroy! :flash => !request.xhr?
  end
  
  private
  
    def load_before_show
      @new_class_group_enrollment = ClassGroupEnrollment.new
      @new_semester = Semester.new
      @new_course = Course.new
    end

    def load_before_index
      @class_group = ClassGroup.new
    end

end
