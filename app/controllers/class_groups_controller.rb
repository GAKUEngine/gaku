class ClassGroupsController < ApplicationController
	
  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_before_show, :only => :show
  before_filter :load_before_index, :only => :index
  before_filter :load_class_group, :only => :destroy

  def create
    super do |format|
      format.js { render }
    end
  end

  def edit
    super do |format|
      format.js { render}
    end
  end

  def update
    super do |format|
      format.js { render}
    end  
  end

  def destroy
    @class_group.destroy  
    render :nothing => true
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

    def load_class_group
      @class_group = ClassGroup.find(params[:id])
    end

end
