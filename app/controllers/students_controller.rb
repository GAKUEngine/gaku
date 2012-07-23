class StudentsController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_class_groups, :only => [:new, :edit]
  before_filter :load_before_show, :only => :show
  
  def index
    @students = Student.all

    respond_to do |format|
      format.html
      format.json {render :json => @students}
    end
  end

  def new
    @student = Student.new
    #@student.profile.build    
  end

  def edit
    @student = Student.find(params[:id])
  end
  
  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      redirect_to @student
    else
      render :edit
    end
  end
  
  def destroy
    destroy! :flash => !request.xhr?
  end

  def new_address
    @student = Student.find(params[:id])
    @student.addresses.build
  end

  def create_address
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      respond_to do |format|
        format.js {render 'create_address'}  
      end
    end  
  end

  def new_guardian
    @student = Student.find(params[:id])
    @student.guardians.build
  end

  def create_guardian
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      respond_to do |format|
        format.js {render 'create_guardian'}  
      end
    end  
  end

  private

    def load_class_groups
      @class_groups = ClassGroup.all
      @class_group_id ||= params[:class_group_id]
    end

    def load_before_show
      @new_guardian = Guardian.new
      @new_note = Note.new
      @new_course_enrollment = CourseEnrollment.new
      @notes = Note.all
    end

end
