class ClassGroups::CoursesController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_class_group, :only => [ :new, :create, :edit, :update, :destroy ]

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    respond_to do |format|
      format.js { render 'destroy' }
    end
  end

  def create
  	super do |format|
  		format.js { render 'create'}
  	end
  end

  def new
    @course = Course.new
    @class_group =  ClassGroup.find(params[:class_group_id])
    render 'new'  
  end

  private 
    def load_class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end


end