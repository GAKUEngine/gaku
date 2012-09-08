class ClassGroups::SemestersController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_class_group, :only => [ :new, :create, :edit, :update, :destroy ]
  
  def create
    super do |format|
      if @class_group.semesters << @semester
        format.js { render 'create' }  
      end
    end 
  end

  def new
    @semester = Semester.new
    render 'new'  
  end

  def destroy
    @semester = Semester.find(params[:id])
    @semester.destroy
    respond_to do |format|
      format.js { render 'destroy' }
    end
  end
  
  private 
    def load_class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end

end